require("nvim-treesitter").install({ "css" })
vim.treesitter.start()
require("conform").formatters_by_ft.css = { "prettier" }
require("conform").formatters.prettier = { prepend_args = { "--tab-width", "2" } }
