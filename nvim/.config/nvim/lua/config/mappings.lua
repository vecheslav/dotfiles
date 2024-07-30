local map = vim.keymap.set

-- default
map("n", "<space>", "<nop>")
map("i", "<C-c>", "<Esc>")
map("n", "<esc>", "<cmd>noh<cr>", { desc = "Clear highlights" })

-- save
map({ "n", "v" }, "<D-s>", "<cmd>w<cr>", { desc = "Save file" })
map("i", "<D-s>", "<ESC><cmd>w<cr>", { desc = "Save file" })

-- terminal
map("n", "<leader>th", "<cmd>horizontal term<cr>", { desc = "Open terminal horizontal" })
map("n", "<leader>tv", "<cmd>vertical term<cr>", { desc = "Open terminal vertical" })
map("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- buffers
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New buffer" })
map("n", "<leader>bd", Utils.bufremove, { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete buffer and window" })
map("n", "<leader><tab>", "<cmd>e #<cr>", { desc = "Switch to other buffer" })

-- windows
map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })

-- resizing windows
map("n", "<D-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<D-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<D-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<D-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- diagnostic
map("n", "<leader>i", "<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<cr>", { desc = "Show diagnostic" })

-- move lines up/down
map("n", "<A-d>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-u>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-d>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-u>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-d>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-u>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- quickfixes
map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
