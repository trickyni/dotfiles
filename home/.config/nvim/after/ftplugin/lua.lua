-- using lua_ls (LSP), stylua (Formatter)
-- could use selene (linter)

require("nvim-treesitter").install({ "lua" })
vim.treesitter.start()
vim.lsp.enable({ "lua_ls", "selene4p_ls" })
require("conform").formatters.stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } }
require("conform").formatters_by_ft.lua = { "stylua" }
