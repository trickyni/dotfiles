vim.lsp.enable({ "tombi" })
vim.treesitter.start()

require("conform").formatters_by_ft.toml = { "tombi", lsp_format = "fallback" }
