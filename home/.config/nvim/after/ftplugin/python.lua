-- using black (formatter)

require("nvim-treesitter").install({ "python" })
vim.treesitter.start()
vim.lsp.enable({})
-- require("conform").formatters.stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } }
require("conform").formatters_by_ft.python = { "black" }
