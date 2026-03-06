require("nvim-treesitter").install({ "bash" })
vim.treesitter.start()
vim.lsp.enable({ "bashls" })
require("conform").formatters_by_ft.sh = { "shfmt", "shellcheck", lsp_format = "fallback" }
require("conform").formatters.shfmt = { prepend_args = { "-i=2" } }
