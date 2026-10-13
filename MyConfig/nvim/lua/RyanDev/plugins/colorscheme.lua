return {
	-- NOTE: Rose pine
	{
		"vague2k/huez.nvim",
		name = "vague2k",
	},
	{
		"Nirmal314/van-gogh.nvim",
		name = "van-gogh",
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "van-gogh",
		},
	},
	{
		"ribru17/bamboo.nvim",
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		-- priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "main", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = false,
				-- disable_background = true,
				-- 	disable_nc_background = false,
				-- 	disable_float_background = false,
				-- extend_background_behind_borders = false,
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
				highlight_groups = {
					ColorColumn = { bg = "#1C1C21" },
					Normal = { bg = "none" }, -- Main background remains transparent
					Pmenu = { bg = "", fg = "#e0def4" }, -- Completion menu background
					PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" }, -- Highlighted completion item
					PmenuSbar = { bg = "#191724" }, -- Scrollbar background
					PmenuThumb = { bg = "#9ccfd8" }, -- Scrollbar thumb
				},
				enable = {
					terminal = false,
					legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},
			})

			-- HACK: set this on the color you want to be persistent
			-- when quit and reopening nvim
		end,
	},
	{
		"bjarneo/aether.nvim",
		branch = "v2",
		name = "aether",
		priority = 1000,
		opts = {
			transparent = true,
			colors = {
				-- Background colors
				bg = "#070506",
				bg_dark = "#070506",
				bg_highlight = "#836f79",

				-- Foreground colors
				-- fg: Object properties, builtin types, builtin variables, member access, default text
				fg = "#ffffff",
				-- fg_dark: Inactive elements, statusline, secondary text
				fg_dark = "#d9b6fd",
				-- comment: Line highlight, gutter elements, disabled states
				comment = "#836f79",

				-- Accent colors
				-- red: Errors, diagnostics, tags, deletions, breakpoints
				red = "#b37580",
				-- orange: Constants, numbers, current line number, git modifications
				orange = "#d5aeb5",
				-- yellow: Types, classes, constructors, warnings, numbers, booleans
				yellow = "#e095b5",
				-- green: Comments, strings, success states, git additions
				green = "#648ed0",
				-- cyan: Parameters, regex, preprocessor, hints, properties
				cyan = "#7c93dd",
				-- blue: Functions, keywords, directories, links, info diagnostics
				blue = "#979fec",
				-- purple: Storage keywords, special keywords, identifiers, namespaces
				purple = "#cd9dcf",
				-- magenta: Function declarations, exception handling, tags
				magenta = "#eddaee",
			},
		},
		config = function(_, opts)
			require("aether").setup(opts)
			vim.cmd.colorscheme("aether")
			-- Enable hot reload
			require("aether.hotreload").setup()
		end,
	},
	{
		"tssm/c64-vim-color-scheme",
		lazy = false,
		priority = 1000,
		config = function()
			vim.o.termguicolors = true
			vim.cmd.colorscheme("c64")

			local bg = "NONE"

			local groups = {
				-- main editor
				"Normal",
				"NormalNC",
				"NormalFloat",
				"FloatBorder",
				"EndOfBuffer",

				-- line numbers / gutter
				"LineNr",
				"CursorLineNr",
				"SignColumn",
				"FoldColumn",

				-- cursor line / columns
				"CursorLine",
				"CursorColumn",
				"ColorColumn",

				-- splits / windows
				"WinSeparator",
				"VertSplit",

				-- popup menus
				"Pmenu",
				"PmenuSel",
				"PmenuSbar",
				"PmenuThumb",

				-- diagnostics / lsp
				"DiagnosticVirtualTextError",
				"DiagnosticVirtualTextWarn",
				"DiagnosticVirtualTextInfo",
				"DiagnosticVirtualTextHint",

				-- status/tab lines
				"StatusLine",
				"StatusLineNC",
				"TabLine",
				"TabLineFill",
				"TabLineSel",
			}

			for _, group in ipairs(groups) do
				vim.api.nvim_set_hl(0, group, { bg = bg })
			end
		end,
	},

	-- NOTE: gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		-- priority = 1000 ,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					folds = false,
					operators = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {
					Pmenu = { bg = "" }, -- Completion menu background
				},
				dim_inactive = false,
				transparent_mode = true,
			})
		end,
	},
	-- NOTE: Kanagwa
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = false },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = {
						wave = {},
						dragon = {},
						all = {
							ui = {
								bg_gutter = "none",
								border = "rounded",
							},
						},
					},
				},
				overrides = function(colors) -- add/modify highlights
					local theme = colors.theme
					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						Pmenu = { fg = theme.ui.shade0, bg = "NONE", blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p2 },

						-- Save an hlgroup with dark background and dimmed foreground
						-- so that you can use it where your still want darker windows.
						-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

						-- Popular plugins that open floats will link to NormalFloat by default;
						-- set their background accordingly if you wish to keep them dark and borderless
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						TelescopeTitle = { fg = theme.ui.special, bold = true },
						TelescopePromptBorder = { fg = theme.ui.special },
						TelescopeResultsNormal = { fg = theme.ui.fg_dim },
						TelescopeResultsBorder = { fg = theme.ui.special },
						TelescopePreviewBorder = { fg = theme.ui.special },
					}
				end,
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
				},
			})
		end,
	},
	-- NOTE: neosolarized
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		config = function()
			require("solarized-osaka").setup({
				transparent = true,
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = false },
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
				sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
				on_highlights = function(hl, c)
					local prompt = "#2d3149"
					hl.TelescopeNormal = {
						bg = c.bg_dark,
						fg = c.fg_dark,
					}
					hl.TelescopeBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptNormal = {
						bg = c.bg_dark,
					}
					hl.TelescopePromptBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptTitle = {
						bg = prompt,
						fg = "#2C94DD",
					}
					hl.TelescopePreviewTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopeResultsTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
				end,
			})
		end,
	},
	-- NOTE : tokyonight
	{
		"folke/tokyonight.nvim",
		name = "folkeTokyonight",
		-- priority = 1000,
		config = function()
			local transparent = true
			local bg = "#011628"
			local bg_dark = "#011423"
			local bg_highlight = "#143652"
			local bg_search = "#0A64AC"
			local bg_visual = "#275378"
			local fg = "#CBE0F0"
			local fg_dark = "#B4D0E9"
			local fg_gutter = "#627E97"
			local border = "#547998"

			require("tokyonight").setup({
				style = "night",
				transparent = transparent,

				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					sidebars = transparent and "transparent" or "dark",
					floats = transparent and "transparent" or "dark",
				},
				on_colors = function(colors)
					colors.bg = transparent and colors.none or bg
					colors.bg_dark = transparent and colors.none or bg_dark
					colors.bg_float = transparent and colors.none or bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = transparent and colors.none or bg_dark
					colors.bg_statusline = transparent and colors.none or bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
			})
			-- vim.cmd("colorscheme tokyonight")
			-- NOTE: Auto switch to tokyonight for markdown files only
			-- vim.api.nvim_create_autocmd("FileType", {
			--     pattern = { "markdown" },
			--     callback = function()
			--         -- Ensure the theme switch only happens once for a buffer
			--         local buffer = vim.api.nvim_get_current_buf()
			--         if not vim.b[buffer].tokyonight_applied then
			--             if vim.fn.expand("%:t") ~= "" and vim.api.nvim_buf_get_option(0, "buftype") ~= "nofile" then
			--                 vim.cmd("colorscheme tokyonight")
			--             end
			--             vim.b[buffer].tokyonight_applied = true
			--         end
			--     end,
			-- })
		end,
	},
	-- NOTE: Nightfox - Carbonfox (Matte Black)
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
					styles = {
						comments = "NONE",
						keywords = "NONE",
					},
				},
				palettes = {
					carbonfox = {
						bg0 = "#0a0a0a", -- Matte black
						bg1 = "#FFFF00",
						bg2 = "#333333",
					},
				},
			})
			-- vim.cmd("colorscheme carbonfox") -- Uncomment to activate
		end,
	},
	{
		"metalelf0/black-metal-theme-neovim",
		config = function()
			require("black-metal").setup({
				-----MAIN OPTIONS-----
				--
				-- Can be one of: bathory | burzum | dark-funeral | darkthrone | emperor | gorgoroth | immortal | impaled-nazarene | khold | marduk | mayhem | nile | taake | thyrfing | venom | windir
				theme = "bathory",
				-- Can be one of: 'light' | 'dark', or set via vim.o.background
				variant = "dark",
				-- Use an alternate, lighter bg
				alt_bg = false,
				-- If true, docstrings will be highlighted like strings, otherwise they will be
				-- highlighted like comments. Note, behavior is dependent on the language server.
				colored_docstrings = true,
				-- If true, highlights the {sign,fold} column the same as cursorline
				cursorline_gutter = true,
				-- If true, highlights the gutter darker than the bg
				dark_gutter = false,
				-- if true favor treesitter highlights over semantic highlights
				favor_treesitter_hl = false,
				-- Don't set background of floating windows. Recommended for when using floating
				-- windows with borders.
				plain_float = false,
				-- Show the end-of-buffer character
				show_eob = true,
				-- If true, enable the vim terminal colors
				term_colors = true,
				-- Keymap (in normal mode) to toggle between light and dark variants.
				toggle_variant_key = nil,
				-- Don't set background
				transparent = true,

				-----DIAGNOSTICS and CODE STYLE-----
				--
				diagnostics = {
					darker = true, -- Darker colors for diagnostic
					undercurl = true, -- Use undercurl for diagnostics
					background = true, -- Use background color for virtual text
				},
				-- The following table accepts values the same as the `gui` option for normal
				-- highlights. For example, `bold`, `italic`, `underline`, `none`.
				code_style = {
					comments = "italic",
					conditionals = "none",
					functions = "none",
					keywords = "none",
					headings = "bold", -- Markdown headings
					operators = "none",
					keyword_return = "none",
					strings = "none",
					variables = "none",
				},

				-----PLUGINS-----
				--
				-- The following options allow for more control over some plugin appearances.
				plugin = {
					lualine = {
						-- Bold lualine_a sections
						bold = true,
						-- Don't set section/component backgrounds. Recommended to not set
						-- section/component separators.
						plain = false,
					},
					cmp = { -- works for nvim.cmp and blink.nvim
						-- Don't highlight lsp-kind items. Only the current selection will be highlighted.
						plain = false,
						-- Reverse lsp-kind items' highlights in blink/cmp menu.
						reverse = false,
					},
				},

				-- CUSTOM HIGHLIGHTS --
				--
				-- Override default colors
				colors = {},
				-- Override highlight groups
				highlights = {},
			})
			-- Convenience function that simply calls `:colorscheme <theme>` with the theme
			-- specified in your config.
			--require("black-metal").load()
		end,
	},
}
