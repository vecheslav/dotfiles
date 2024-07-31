local api = vim.api
local validate = vim.validate
local util = require("vim.lsp.util")
local npcall = vim.F.npcall

---@diagnostic disable: param-type-mismatch
local M = {}

-- FIXME: Workaround for https://github.com/neovim/neovim/issues/28058
-- local make_client_capabilities = vim.lsp.protocol.make_client_capabilities
-- function M.make_client_capabilities()
-- 	local capabilities = make_client_capabilities()
-- 	if not (capabilities.workspace or {}).didChangeWatchedFiles then
-- 		vim.notify("lsp capability didChangeWatchedFiles is already disabled", vim.log.levels.WARN)
-- 	else
-- 		capabilities.workspace.didChangeWatchedFiles = nil
-- 	end
--
-- 	return capabilities
-- end

local function find_window_by_var(name, value)
	for _, win in ipairs(api.nvim_list_wins()) do
		if npcall(api.nvim_win_get_var, win, name) == value then
			return win
		end
	end
end

local function close_preview_window(winnr, bufnrs)
	vim.schedule(function()
		-- exit if we are in one of ignored buffers
		if bufnrs and vim.list_contains(bufnrs, api.nvim_get_current_buf()) then
			return
		end

		local augroup = "preview_window_" .. winnr
		pcall(api.nvim_del_augroup_by_name, augroup)
		pcall(api.nvim_win_close, winnr, true)
	end)
end

local function close_preview_autocmd(events, winnr, bufnrs)
	local augroup = api.nvim_create_augroup("preview_window_" .. winnr, {
		clear = true,
	})

	-- close the preview window when entered a buffer that is not
	-- the floating window buffer or the buffer that spawned it
	api.nvim_create_autocmd("BufEnter", {
		group = augroup,
		callback = function()
			close_preview_window(winnr, bufnrs)
		end,
	})

	if #events > 0 then
		api.nvim_create_autocmd(events, {
			group = augroup,
			buffer = bufnrs[2],
			callback = function()
				close_preview_window(winnr)
			end,
		})
	end
end

function M.open_floating_preview(contents, syntax, opts)
	validate({
		contents = { contents, "t" },
		syntax = { syntax, "s", true },
		opts = { opts, "t", true },
	})
	opts = opts or {}
	opts.wrap = opts.wrap ~= false -- wrapping by default
	opts.focus = opts.focus ~= false
	opts.close_events = opts.close_events or { "CursorMoved", "CursorMovedI", "InsertCharPre" }

	local bufnr = api.nvim_get_current_buf()

	-- check if this popup is focusable and we need to focus
	if opts.focus_id and opts.focusable ~= false and opts.focus then
		-- Go back to previous window if we are in a focusable one
		local current_winnr = api.nvim_get_current_win()
		if npcall(api.nvim_win_get_var, current_winnr, opts.focus_id) then
			api.nvim_command("wincmd p")
			return bufnr, current_winnr
		end
		do
			local win = find_window_by_var(opts.focus_id, bufnr)
			if win and api.nvim_win_is_valid(win) and vim.fn.pumvisible() == 0 then
				-- focus and return the existing buf, win
				api.nvim_set_current_win(win)
				api.nvim_command("stopinsert")
				return api.nvim_win_get_buf(win), win
			end
		end
	end

	-- check if another floating preview already exists for this buffer
	-- and close it if needed
	local existing_float = npcall(api.nvim_buf_get_var, bufnr, "lsp_floating_preview")
	if existing_float and api.nvim_win_is_valid(existing_float) then
		api.nvim_win_close(existing_float, true)
	end

	-- Create the buffer
	local floating_bufnr = api.nvim_create_buf(false, true)

	-- Set up the contents, using treesitter for markdown
	local do_stylize = syntax == "markdown" and vim.g.syntax_on ~= nil
	if do_stylize then
		vim.lsp.util.stylize_markdown(floating_bufnr, contents, opts)
	else
		-- Clean up input: trim empty lines
		contents = vim.split(table.concat(contents, "\n"), "\n", { trimempty = true })

		if syntax then
			vim.bo[floating_bufnr].syntax = syntax
		end
		api.nvim_buf_set_lines(floating_bufnr, 0, -1, true, contents)
	end

	-- Compute size of float needed to show (wrapped) lines
	if opts.wrap then
		opts.wrap_at = opts.wrap_at or api.nvim_win_get_width(0)
	else
		opts.wrap_at = nil
	end
	local width, height = util._make_floating_popup_size(api.nvim_buf_get_lines(floating_bufnr, 0, -1, false), opts)

	local float_option = util.make_floating_popup_options(width, height, opts)
	local floating_winnr = api.nvim_open_win(floating_bufnr, false, float_option)

	if do_stylize then
		vim.wo[floating_winnr].conceallevel = 2
		vim.wo[floating_winnr].concealcursor = "n"
	end
	-- disable folding
	vim.wo[floating_winnr].foldenable = false
	-- soft wrapping
	vim.wo[floating_winnr].wrap = opts.wrap
	-- vim.wo[floating_winnr].winhighlight = "NormalFloat:SolidFloat,Normal:SolidFloat,FloatBorder:SolidFloat"

	vim.bo[floating_bufnr].modifiable = false
	vim.bo[floating_bufnr].bufhidden = "wipe"

	api.nvim_buf_set_keymap(
		floating_bufnr,
		"n",
		"q",
		"<cmd>bdelete<cr>",
		{ silent = true, noremap = true, nowait = true }
	)
	close_preview_autocmd(opts.close_events, floating_winnr, { floating_bufnr, bufnr })

	-- save focus_id
	if opts.focus_id then
		api.nvim_win_set_var(floating_winnr, opts.focus_id, bufnr)
	end
	api.nvim_buf_set_var(bufnr, "lsp_floating_preview", floating_winnr)

	return floating_bufnr, floating_winnr
end

local TELESCOPE_MIN_WIDTH = 120
local TELESCOPE_MIN_HEIGHT = 32

function M.telescope_center_window()
	return function(self)
		local layout = require("telescope.pickers.window").get_initial_window_options(self)
		local prompt = layout.prompt
		local results = layout.results
		local preview = layout.preview

		local screen_width = vim.o.columns
		local screen_height = vim.o.lines - 2

		local width = screen_width
		local height = screen_height
		local pos = { 0, 0 }
		local is_small = true

		if width > TELESCOPE_MIN_WIDTH then
			width = math.floor(width * 0.5)
			pos[2] = math.floor((screen_width - width) * 0.5)
		end

		if height > TELESCOPE_MIN_HEIGHT then
			height = math.floor(height * 0.8)
			is_small = false
		end

		local wline = pos[1] + 1
		local wcol = pos[2] + 1

		-- Height
		prompt.height = 1
		preview.height = self.previewer and math.floor(height * 0.6) or 0
		results.height = height - prompt.height - (self.previewer and preview.height or 0)

		-- Line
		local rows = { prompt, results, preview }
		local next_line = wline
		for _, v in pairs(rows) do
			if v.height ~= 0 then
				v.line = next_line
				next_line = v.line + v.height
			end
		end

		-- Add border as separator
		preview.border = { 1, 1, 1, 1 }
		results.border = { 1, 1, 1, 1 }
		prompt.border = { 0, 1, 0, 1 }
		prompt.title = ""
		preview.title = ""

		if self.previewer then
			results.border = { 1, 1, 0, 1 }
			preview.line = preview.line + 1
			preview.height = preview.height - 1
		end

		if is_small then
			preview.border = { 1, 1, 0, 1 }
			results.border = { 1, 1, 0, 1 }
		end

		-- Width
		prompt.width = width
		results.width = prompt.width
		preview.width = prompt.width

		-- Col
		prompt.col = wcol
		results.col = prompt.col
		preview.col = prompt.col

		if not self.previewer then
			layout.preview = nil
		end

		return layout
	end
end

function M.telescope_buffer_window()
	return function(self)
		local layout = require("telescope.pickers.window").get_initial_window_options(self)
		local prompt = layout.prompt
		local results = layout.results
		local preview = layout.preview

		-- Full width popup
		local width = vim.o.columns
		local height = vim.o.lines - 2
		local pos = { 0, 0 }

		if width > TELESCOPE_MIN_WIDTH then
			width = math.floor(width * 0.32)
			pos[2] = vim.o.columns - width
		end

		---@diagnostic disable-next-line: unused-local
		local wline = pos[1] + 1
		local wcol = pos[2] + 1

		-- Height
		prompt.height = 1
		preview.height = self.previewer and math.floor(height * 0.5) or 0
		results.height = height - prompt.height - (self.previewer and preview.height or 0)

		-- Line
		local rows = { prompt, results, preview }
		local next_line = 1
		for _, v in pairs(rows) do
			if v.height ~= 0 then
				v.line = next_line
				next_line = v.line + v.height
			end
		end

		if self.previewer then
			preview.height = preview.height - 1
			preview.line = preview.line + 1
		end
		-- Add border as separator
		preview.border = { 1, 0, 0, 1 }
		results.border = { 0, 0, 0, 1 }
		prompt.border = { 0, 0, 0, 1 }
		prompt.title = ""
		preview.title = ""

		-- Width
		prompt.width = width
		results.width = prompt.width
		preview.width = prompt.width

		-- Col
		prompt.col = wcol
		results.col = prompt.col
		preview.col = prompt.col

		if not self.previewer then
			layout.preview = nil
		end

		return layout
	end
end

return M
