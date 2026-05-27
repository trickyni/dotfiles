require("nvim-treesitter").install({ "html" })
vim.treesitter.start()
vim.opt.makeprg = "firefox %"
require("conform").formatters_by_ft.html = { "prettier" }
require("conform").formatters.prettier = { prepend_args = { "--tab-width", "2" } }
