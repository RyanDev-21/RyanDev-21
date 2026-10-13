return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- NOTE: LSP Keybinds
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- keymaps
				opts.desc = "Show LSP references"
				vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, opts)

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)
			end,
		})

		-- Define sign icons for each severity
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		-- Set the diagnostic config with all icons
		vim.diagnostic.config({
			signs = {
				text = signs,
			},
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		})

		-- Get capabilities from cmp-nvim-lsp
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()
		-- Export capabilities globally so nvim-jdtls can read it
		_G.lsp_capabilities = capabilities
		-- Helper function for root_pattern
		local function root_pattern(...)
			local patterns = { ... }
			return function(fname)
				local util = vim.fs
				for _, pattern in ipairs(patterns) do
					local found = util.find(pattern, { path = fname, upward = true })[1]
					if found then
						return vim.fs.dirname(found)
					end
				end
			end
		end

		-- Configure lua_ls
		vim.lsp.config("lua_ls", {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			root_markers = {
				".luarc.json",
				".luarc.jsonc",
				".luacheckrc",
				".stylua.toml",
				"stylua.toml",
				"selene.toml",
				"selene.yml",
				".git",
			},
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- Configure emmet_ls
		vim.lsp.config("emmet_ls", {
			cmd = { "emmet-ls", "--stdio" },
			filetypes = {
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
			},
			capabilities = capabilities,
		})

		-- Configure omnisharp
		vim.lsp.config("omnisharp", {
			cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
			filetypes = { "cs" },
			root_markers = { "*.sln", "*.csproj", ".git" },
			capabilities = capabilities,
			settings = {
				RoslynExtensionsOptions = {
					EnableAnalyzersSupport = true,
					LocationPaths = {},
				},
				FormattingOptions = {
					EnableEditorConfigSupport = true,
				},
				FileOptions = {
					SystemExcludeSearchPatterns = { "bin/**", "obj/**" },
				},
			},
		})

		-- Configure emmet_language_server
		vim.lsp.config("emmet_language_server", {
			cmd = { "emmet-language-server", "--stdio" },
			filetypes = {
				"css",
				"eruby",
				"html",
				"javascript",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"pug",
				"typescriptreact",
			},
			capabilities = capabilities,
			settings = {
				includeLanguages = {},
				excludeLanguages = {},
				extensionsPath = {},
				preferences = {},
				showAbbreviationSuggestions = true,
				showExpandedAbbreviation = "always",
				showSuggestionsAsSnippets = false,
				syntaxProfiles = {},
				variables = {},
			},
		})

		-- Configure ts_ls (TypeScript/JavaScript)
		vim.lsp.config("ts_ls", {
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
			root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
			capabilities = capabilities,
			settings = {
				preferences = {
					includeCompletionsForModuleExports = true,
					includeCompletionsForImportStatements = true,
				},
			},
		})

		-- Configure rust_analyzer (Corrected Syntax)
		vim.lsp.config("rust_analyzer", {
			capabilities = capabilities,
			cmd = { "rust-analyzer" },
			filetypes = { "rust" },
			root_markers = { "Cargo.toml", ".git" },
			single_file_support = true,
			settings = {
				["rust-analyzer"] = {
					procMacro = {
						enable = true,
					},
					cargo = {
						buildScripts = {
							enable = true,
						},
					},
					diagnostics = {
						enable = true,
					},
					completion = {
						postfix = {
							enable = true,
						},
					},
				},
			},
			before_init = function(init_params, config)
				if config.settings and config.settings["rust-analyzer"] then
					init_params.initializationOptions = config.settings["rust-analyzer"]
				end
			end,
		})
		-- Configure gopls
		vim.lsp.config("gopls", {
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_markers = { "go.work", "go.mod", ".git" },
			capabilities = capabilities,
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
			},
		})

		-- --Configure python
		-- vim.lsp.config("python-lsp-server",{
		--     cmd = {"pylsp"},
		--     filetypes = {"py"},
		--     root_markers = {
		--         "pyproject.toml",
		--         "setup.py",
		--         "setup.cfg",
		--         "requirements.txt",
		--         "Pipefile",
		--         ".git"
		--     },
		--     capabilities = capabilities,
		-- })

		-- Configure clangd
		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--completion-style=detailed",
			},
			filetypes = { "c", "cpp", "objc", "objcpp" },
			root_markers = { "compile_commands.json", ".git" },
			capabilities = capabilities,
		})

		-- Configure csharp_ls
		vim.lsp.config("csharp_ls", {
			cmd = { "csharp-ls" },
			filetypes = { "cs" },
			root_markers = { "*.sln", "*.csproj", ".git" },
			capabilities = capabilities,
			settings = {
				AutomaticWorkspaceInit = true,
			},
		})

		-- Enable LSP servers
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("emmet_ls")
		vim.lsp.enable("omnisharp")
		vim.lsp.enable("emmet_language_server")
		vim.lsp.enable("denols")
		vim.lsp.enable("ts_ls")
		vim.lsp.enable("gopls")
		vim.lsp.enable("clangd")
		vim.lsp.enable("csharp_ls")
		vim.lsp.enable("rust_analyzer")
		-- =====================================================================
		-- JAVA (JDTLS) BULLETPROOF CONFIGURATION
		-- =====================================================================
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function(ev)
				local home = os.getenv("HOME")
				local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
				local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

				local launcher_jar = home
					.. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar"
				local config_dir = home .. "/.local/share/nvim/mason/packages/jdtls/config_linux"

				-- Bulletproof root detection logic
				local current_buf_name = vim.api.nvim_buf_get_name(ev.buf or 0)
				local current_dir = vim.fs.dirname(current_buf_name)
				local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
				local root_dir = nil

				if current_buf_name ~= "" then
					root_dir = vim.fs.root(ev.buf or 0, root_markers)
				end

				if not root_dir or root_dir == "" then
					if current_dir and current_dir ~= "" then
						root_dir = current_dir
					else
						root_dir = vim.fn.getcwd()
					end
				end

				local config = {
					cmd = {
						"/usr/lib/jvm/java-21-openjdk/bin/java",
						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.level=ALL",
						"-Xmx1g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens",
						"java.base/java.lang=ALL-UNNAMED",
						"--add-opens",
						"java.base/java.util=ALL-UNNAMED",

						"-jar",
						launcher_jar,
						"-configuration",
						config_dir,
						"-data",
						workspace_dir,
					},
					root_dir = root_dir,
					capabilities = capabilities,
					settings = {
						java = {
							signatureHelp = { enabled = true },
							contentProvider = { preferred = "fernflower" },
						},
					},
				}

				require("jdtls").start_or_attach(config)
			end,
		})
	end,
}
