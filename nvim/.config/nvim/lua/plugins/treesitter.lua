return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    config = function()
      require("nvim-treesitter.configs").setup({
        compilers = { "clang", "gcc" },
        ensure_installed = require("config.languages").treesitter,
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<A-k>",
            node_incremental = "<A-k>",
            scope_incremental = false,
            node_decremental = "<A-j>",
          },
        },
      })
    end,
  },
}
