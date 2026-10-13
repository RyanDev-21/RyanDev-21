return {
  "folke/zen-mode.nvim",
  opts = {
    window = {
      backdrop = 0.95,   -- dim background slightly
      width = 120,       -- width of the text area
      options = {
        signcolumn = "no",
        number = true,
        relativenumber = true,
        cursorline = false,
      },
    },
    plugins = {
      kitty = { enabled = true }, -- if you use Kitty, this adjusts font size
      gitsigns = { enabled = false },
      tmux = { enabled = false },
    },
  },
  keys = {
    { "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
  },
}

