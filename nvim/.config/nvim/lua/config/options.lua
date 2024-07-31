-- Global
vim.g.mapleader = " "

-- Opt
local opt = vim.opt

opt.ignorecase = false
opt.smartcase = true
opt.mouse = "a"
opt.cursorline = true
opt.clipboard = "unnamedplus"
opt.number = true
opt.relativenumber = true

-- Performance
opt.timeoutlen = 300
opt.ttimeoutlen = 0
opt.updatetime = 200

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true

opt.fileformat = "unix"
opt.fileformats = "unix,dos"

opt.pumheight = 10
opt.showmode = false
opt.wrap = false
opt.scrolloff = 8
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  diff = "╱",
  -- eob = " ",
}
opt.listchars = {
  eol = "󰌑",
}

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldnestmax = 4

-- Colors
opt.termguicolors = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- Undo / Backup
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.backupdir = vim.fn.stdpath("data") .. "/backup"
opt.undofile = true
opt.backup = true

-- Diagnostic
vim.diagnostic.config({
  virtual_text = false,
  float = {
    header = "",
    prefix = "",
  },
})

-- Overrides
vim.lsp.util.open_floating_preview = Overrides.open_floating_preview
-- vim.lsp.protocol.make_client_capabilities = Overrides.make_client_capabilities

-- Custom commands
vim.api.nvim_create_user_command("ClearShada", Utils.clear_shada, { desc = "Clears all the .tmp shada files" })
