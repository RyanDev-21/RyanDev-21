return {
	"nvim-telescope/telescope.nvim",
	branch = "master", -- using master to fix issues with deprecated to definition warnings
	-- '0.1.x' for stable ver.
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"andrew-george/telescope-themes",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.load_extension("fzf")
		telescope.load_extension("themes")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						-- ["<C-k>"] = actions.move_selection_previous,
						-- ["<C-j>"] = actions.move_selection_next,
					},
				},
			},
			extensions = {
				themes = {
					enable_previewer = true,
					enable_live_preview = true,
					persist = {
						enabled = true,
						path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
					},
				},
			},
		})

		-- Telescope C64-style background
		local bg = "NONE"
		local border = "#8b7bdc"
		local fg = "#ffffff"

		local function set_telescope_hl()
			vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = bg })
			vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = bg, fg = border })

			vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = bg })
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = bg, fg = border })
			vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = border, fg = fg })

			vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = bg })
			vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = bg, fg = border })
			vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = border, fg = fg })

			vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = bg })
			vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = bg, fg = border })
			vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = border, fg = fg })

			vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#ffcd75", bold = true })
			vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#2b1f70", fg = fg })
			vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = "#ffcd75", bg = "#2b1f70" })
		end

		set_telescope_hl()

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = set_telescope_hl,
		})

		-- Keymap
		vim.keymap.set("n", "<leader>pr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })

		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end, { desc = "Find Connected Words under cursor" })

		vim.keymap.set("n", "<leader>ths", "<cmd>Telescope themes<CR>", {
			noremap = true,
			silent = true,
			desc = "Theme Switcher",
		})
	end,
}
