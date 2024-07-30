---@diagnostic disable-next-line: unused-local
local autocmd = vim.api.nvim_create_autocmd

-- Enter insert mode when switching to terminal
autocmd({ "TermOpen" }, {
	group = vim.api.nvim_create_augroup("termim_open", { clear = true }),
	callback = function(event)
		vim.cmd("setlocal nonumber")
		vim.cmd("setlocal norelativenumber")
		vim.cmd("setlocal signcolumn=no")
		vim.cmd("startinsert!")
		vim.cmd("set cmdheight=1")
		-- vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Close terminal buffer on process exit
autocmd("BufLeave", { pattern = "term://*", command = "stopinsert" })
