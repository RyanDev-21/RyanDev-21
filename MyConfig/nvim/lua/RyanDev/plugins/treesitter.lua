return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"query",
					"go",
					"c",
					"cpp",
					"javascript",
					"typescript",
					"tsx",
					"json",
					"css",
					"markdown",
					"markdown_inline",
					"bash",
				},
				sync_install = false,
				auto_install = true,

				highlight = {
					enable = true,
				},

				indent = {
					enable = true,
				},
			})
		end,
	}, -- {
	-- 	"windwp/nvim-ts-autotag",
	-- 	enabled = true,
	-- 	ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
	-- 	config = function()
	-- 		-- Independent nvim-ts-autotag setup
	-- 		require("nvim-ts-autotag").setup({
	-- 			opts = {
	-- 				enable_close = true, -- Auto-close tags
	-- 				enable_rename = true, -- Auto-rename pairs
	-- 				enable_close_on_slash = false, -- Disable auto-close on trailing `</`
	-- 			},
	-- 			per_filetype = {
	-- 				["html"] = {
	-- 					enable_close = true, -- Disable auto-closing for HTML
	-- 				},
	-- 				["typescriptreact"] = {
	-- 					enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
