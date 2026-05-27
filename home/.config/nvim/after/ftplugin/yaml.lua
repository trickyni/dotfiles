require("nvim-treesitter").install({ "yaml" })
vim.treesitter.start()
require("conform").formatters_by_ft.yaml = { "prettier" }
require("conform").formatters.prettier = { prepend_args = { "--tab-width", "2" } }
