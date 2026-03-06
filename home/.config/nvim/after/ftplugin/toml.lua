-- using tombi (LSP)
-- https://taplo.tamasfe.dev/
require("nvim-treesitter").install({ "toml" })
vim.treesitter.start()
vim.lsp.enable({ "tombi" }) --FIX: llm code!
require("conform").formatters_by_ft.toml = { "tombi" }
