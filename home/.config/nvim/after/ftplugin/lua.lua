vim.lsp.enable({ "lua_ls" })
vim.treesitter.start()
require("conform").formatters.stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } }
require("conform").formatters_by_ft.lua = { "stylua", lsp_format = "fallback" }
