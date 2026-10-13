require("RyanDev.setting")
require("RyanDev.lazy")
require("current-theme")
require("Custom.terminal")
vim.g.lazyvim_check_order = false
-- Match Neovim background to terminal
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
