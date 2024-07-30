---@diagnostic disable: param-type-mismatch
local M = {}

function M.is_win()
---@diagnostic disable-next-line: undefined-field
  return vim.uv.os_uname().sysname:find("Windows") ~= nil
end

function M.get_visual_multi()
	return vim.b['visual_multi'] and "%#VM_StatusLine#󰎂 MULTI" or ""
end

function M.bufremove(buf)
	buf = buf or 0
	buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

	if vim.bo.modified then
		local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No")
		if choice == 0 then -- Cancel
			return
		end
		if choice == 1 then -- Yes
			vim.cmd.write()
		end
	end

	for _, win in ipairs(vim.fn.win_findbuf(buf)) do
		vim.api.nvim_win_call(win, function()
			if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
				return
			end
			-- Try using alternate buffer
			local alt = vim.fn.bufnr("#")
			if alt ~= buf and vim.fn.buflisted(alt) == 1 then
				vim.api.nvim_win_set_buf(win, alt)
				return
			end

			-- Try using previous buffer
			local has_previous = pcall(vim.cmd, "bprevious")
			if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
				return
			end

			-- Create new listed buffer
			local new_buf = vim.api.nvim_create_buf(true, false)
			vim.api.nvim_win_set_buf(win, new_buf)
		end)
	end
	if vim.api.nvim_buf_is_valid(buf) then
		pcall(vim.cmd, "bdelete! " .. buf)
	end
end

function M.clear_shada()
	local shada_path = vim.fn.expand(vim.fn.stdpath("data") .. "/shada")
	local files = vim.fn.glob(shada_path .. "/*", false, true)
	local all_success = 0
	for _, file in ipairs(files) do
		local file_name = vim.fn.fnamemodify(file, ":t")
		if file_name == "main.shada" then
			-- skip your main.shada file
			goto continue
		end
		local success = vim.fn.delete(file)
		all_success = all_success + success
		if success ~= 0 then
			vim.notify("Couldn't delete file '" .. file_name .. "'", vim.log.levels.WARN)
		end
		::continue::
	end
	if all_success == 0 then
		vim.print("Successfully deleted all temporary shada files")
	end
end

return M
