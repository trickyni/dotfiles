require("nvim-treesitter").install({ "qmljs", "qmldir" })
vim.treesitter.start()
vim.lsp.enable({ "qmlls" })
vim.lsp.document_color.enable(false)
require("conform").formatters_by_ft.qml = { "qmlformat" }
require("conform").formatters.qmlformat = { append_args = { "-w", "2" } }
