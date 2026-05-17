-- Using ts_ls (LSP), prettier (Formatter)
-- could use OXFMT (formatter), OXLINT (linter), or ESLINT (linter)

require("nvim-treesitter").install({ "javascript", "jsx", "json", "embedded_template", "typescript" })
vim.treesitter.start()
vim.opt.makeprg = "bun %"
vim.lsp.enable({ "ts_ls" })
require("conform").formatters_by_ft.javascriptreact = { "prettier", lsp_format = "fallback" }
