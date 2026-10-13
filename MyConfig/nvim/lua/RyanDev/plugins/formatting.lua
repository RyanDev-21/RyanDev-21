return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters = {
                ["markdown-toc"] = {
                    condition = function(_, ctx)
                        for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                            if line:find("<!%-%- toc %-%->") then
                                return true
                            end
                        end
                    end,
                },
            },
            formatters_by_ft = {
                javascript = { "biome-check" },
                typescript = { "biome-check" },
                javascriptreact = { "biome-check" },
                typescriptreact = { "biome-check" },
                css = { "biome-check" },
                html = { "biome-check" },
                svelte = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                graphql = { "prettier" },
                liquid = { "prettier" },
                lua = { "stylua" },
                -- Use clang-format for C/C++
                c = { "clang-format" },
                cpp = { "clang-format" },
                markdown = { "prettier", "markdown-toc" },
            },
            -- This handles the auto-format on :w
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            },
        })

        -- Custom formatter args
        conform.formatters.prettier = {
            args = { "--stdin-filepath", "$FILENAME", "--tab-width", "4", "--use-tabs", "false" },
        }
        
        -- Optional: specific style for clang-format
        conform.formatters["clang-format"] = {
            prepend_args = { "-style=file" },
        }

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range" })
    end,
}
