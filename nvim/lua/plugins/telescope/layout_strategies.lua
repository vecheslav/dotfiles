local M = {}

local MIN_COLUMNS = 120

function M.right_pane()
	return function(self)
		local layout = require("telescope.pickers.window").get_initial_window_options(self)
		local prompt = layout.prompt
		local results = layout.results
		local preview = layout.preview

		-- Full width popup
		local width = vim.o.columns
		local height = vim.o.lines - 2
		local pos = { 0, 0 }

		if width > MIN_COLUMNS then
			width = math.floor(width * 0.4)
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
