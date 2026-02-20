vim.lsp.enable({ "ts_ls" })
vim.opt.makeprg = "bun %"
vim.treesitter.start()
require("conform").formatters_by_ft.javascript = { "prettier", lsp_format = "fallback" }
