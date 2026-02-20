vim.pack.add({
  { src = "https://github.com/selimacerbas/live-server.nvim" },
  { src = "https://github.com/selimacerbas/markdown-preview.nvim" },
  { src = "https://github.com/kais-radwan/ascii-mermaid" },
})

require("markdown_preview").setup({ mermaid_renderer = "js", scroll_sync = false })
require("ascii-mermaid").setup()
