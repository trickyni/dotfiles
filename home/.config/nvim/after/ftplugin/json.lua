require("nvim-treesitter").install({ "json" })
vim.treesitter.start()
require("conform").formatters_by_ft.json = { "prettier" }
require("conform").formatters.prettier = { prepend_args = { "--tab-width", "2" } }
