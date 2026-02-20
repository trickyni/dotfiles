vim.lsp.enable({ "bashls" })
vim.treesitter.start()
require("conform").formatters_by_ft.sh = { "shfmt", "shellcheck", lsp_format = "fallback" }
require("conform").formatters.shfmt = { prepend_args = { "-i = 2" } }
