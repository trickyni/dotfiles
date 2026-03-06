require("nvim-treesitter").install({ "mermaid" })
vim.treesitter.start()

vim.pack.add({
  { src = "https://github.com/selimacerbas/live-server.nvim" },
  { src = "https://github.com/selimacerbas/markdown-preview.nvim" },
})

require("markdown_preview").setup({ mermaid_renderer = "js", scroll_sync = false })
