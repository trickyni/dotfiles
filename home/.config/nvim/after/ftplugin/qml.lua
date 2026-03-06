require("nvim-treesitter").install({ "qmljs", "qmldir" })
vim.treesitter.start()
vim.lsp.enable({ "qmlls" })
require("conform").formatters_by_ft.qml = { lsp_format = "never" }
