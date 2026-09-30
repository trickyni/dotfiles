require("nvim-treesitter").install({ "rust", "ron" })
vim.treesitter.start()
vim.lsp.enable({ "ron-lsp" })
require("conform").formatters_by_ft.ron = { lsp_format = "prefer" }
