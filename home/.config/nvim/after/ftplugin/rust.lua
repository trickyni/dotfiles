-- using rust_analyzer (LSP), rustmft (Formatter)
-- could use clippy (linter)

require("nvim-treesitter").install({ "rust", "ron" })
vim.treesitter.start()
vim.lsp.enable({ "rust_analyzer" })
require("conform").formatters_by_ft.lua = { "rustfmt", lsp_format = "fallback" }
