---- Options -------------------------------------------------------------------
vim.opt_local.spell = true -- spellcheck
vim.opt_local.shiftwidth = 2 -- ensures tabs == 2 whitespaces
vim.opt_local.textwidth = 0
vim.treesitter.start()

---- Keymaps -------------------------------------------------------------------
-- make up/down consider wrapped text
vim.keymap.set({ "n", "v" }, "k", "gk", { remap = false, buffer = true, silent = true })
vim.keymap.set({ "n", "v" }, "j", "gj", { remap = false, buffer = true, silent = true })
vim.cmd('syntax match Emdash "—" conceal cchar=𖢊')

---- Custom Syntax -------------------------------------------------------------
vim.cmd('syntax region EditNote start="|NOTE" end="||" conceal cchar=𖡗')
vim.api.nvim_set_hl(0, "EditNote", { fg = "#e86045", bg = "#3b3228" })
vim.cmd('syntax region MossText matchgroup=Conceal start="+G|" end="|+" concealends')
vim.cmd('syntax region ScarletText matchgroup=Conceal start="+R|" end="|+" concealends')
vim.cmd('syntax region SandText matchgroup=Conceal start="+S|" end="|+" concealends')
vim.cmd('syntax region SaffronText matchgroup=Conceal start="+Y|" end="|+" concealends')
vim.cmd('syntax region OrangeText matchgroup=Conceal start="+O|" end="|+" concealends')
vim.cmd('syntax region CyanText matchgroup=Conceal start="+B|" end="|+" concealends')
vim.cmd('syntax region CeladonText matchgroup=Conceal start="+T|" end="|+" concealends')
vim.cmd("digraph -- 8212")

---- LSP -----------------------------------------------------------------------
vim.lsp.enable({ "ltex_plus", "rumdl" })

---- Plugins -------------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/bullets-vim/bullets.vim" },
  { src = "https://github.com/selimacerbas/live-server.nvim" },
  { src = "https://github.com/selimacerbas/markdown-preview.nvim" },
  { src = "https://github.com/kais-radwan/ascii-mermaid" },
})

---- conform.nvim --------------------------------------------------------------
--stylua: ignore
require("conform").formatters_by_ft.markdown = {"rumdl"}

---- RenderMarkdown ------------------------------------------------------------
require("render-markdown").setup({
  render_modes = true,
  completions = { lsp = { enabled = true } },
  checkbox = {
    checked = { icon = "󰫈", scope_highlight = "RenderMarkdownCheckedItem" },
    unchecked = { icon = "󰋙", scope_highlight = nil },
        --stylua: ignore
        custom = {
          sixth     = { raw = "[a]", rendered = "󰫃", highlight = "RenderMarkdownBullet" },
          third     = { raw = "[b]", rendered = "󰫄", highlight = "RenderMarkdownBullet" },
          half      = { raw = "[o]", rendered = "󰫅", highlight = "RenderMarkdownBullet" },
          twothirds = { raw = "[d]", rendered = "󰫆", highlight = "RenderMarkdownBullet" },
          fivesix   = { raw = "[e]", rendered = "󰫇", highlight = "RenderMarkdownBullet" },
          todo      = { raw = "[-]", rendered = "󰥔", highlight = "RenderMarkdownTodo" },
        },
  },
  wiki = { scope_highlight = "RenderMarkdownWikiLinkText" },
  bullet = { icons = { "󰆧" }, right_pad = 0 },
  pipe_table = {
    preset = "round",
    alignment_indicator = "┈",
  },
  dash = {
    enabled = true,
    render_modes = false,
    icon = "─",
    width = "full",
    left_margin = 0,
  },
  latex = { enabled = false },
  win_options = {
    conceallevel = { rendered = vim.o.conceallevel },
    concealcursor = { rendered = vim.o.concealcursor },
  },
})

---- mermaid chart previewers ----------------------------------------------
require("markdown_preview").setup({ mermaid_renderer = "js", scroll_sync = false })
require("ascii-mermaid").setup()

---- bullets-vim -----------------------------------------------------------
vim.g.bullets_checkbox_markers = " abodeX"
