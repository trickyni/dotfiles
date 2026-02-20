vim.lsp.enable({ "qmlls" })
vim.treesitter.start()
require("conform").formatters_by_ft.qml = { lsp_format = "never" }
