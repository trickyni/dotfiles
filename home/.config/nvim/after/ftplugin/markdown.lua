---- Options -------------------------------------------------------------------
vim.opt_local.spell = true -- spellcheck
vim.opt_local.shiftwidth = 2 -- ensures tabs == 2 whitespaces
vim.opt_local.textwidth = 0
-- vim.fn.setcellwidths({ { 0x2014, 0x2014, 2 } })
vim.cmd("digraph -- 8212")

---- Treesitter ---------------------------------------------------------------
require("nvim-treesitter").install({ "markdown", "markdown_inline", "yaml" })
vim.treesitter.start()

---- LSP -----------------------------------------------------------------------
-- vim.lsp.enable({ "ltex_plus", "rumdl", "markdown_oxide" })
vim.lsp.enable({ "rumdl" })

---- Keymaps -------------------------------------------------------------------
-- make up/down consider wrapped text
local map = vim.keymap.set
map("n", "grl", '<cmd>lua vim.lsp.enable({"ltex_plus","markdown_oxide"})<CR>', { desc = "Enable ltex_ls" })
map({ "n", "v" }, "k", "gk", { remap = false, buffer = true, silent = true })
map({ "n", "v" }, "j", "gj", { remap = false, buffer = true, silent = true })
map("n", "gb", "<cmd>Obsidian backlinks<CR>", { desc = "Backlinks", remap = false })
map("n", "o", "<cmd>InsertNewBullet<CR>", { remap = false, buffer = true })

map(
  "n",
  "<leader>if",
  "<cmd>lua require('footnote').new_footnote()<CR>",
  { buffer = true, desc = "Insert new footnote" }
)
map(
  "n",
  "]f",
  "<cmd>lua require('footnote').next_footnote()<CR>",
  { remap = false, buffer = true, desc = "Next footnote" }
)
map(
  "n",
  "[f",
  "<cmd>lua require('footnote').prev_footnote()<CR>",
  { remap = false, buffer = true, desc = "Next footnote" }
)
map("n", "<leader>mm", "<cmd>MarkmapOpen<CR>", { buffer = true, desc = "Open MarkMap" })

---- Custom Syntax -------------------------------------------------------------
vim.cmd('syntax region ScarletText matchgroup=Conceal start="+R|" end="|+" concealends')
vim.cmd('syntax region MossText matchgroup=Conceal start="+G|" end="|+" concealends')
vim.cmd('syntax region SandText matchgroup=Conceal start="+S|" end="|+" concealends')
vim.cmd('syntax region SaffronText matchgroup=Conceal start="+Y|" end="|+" concealends')
vim.cmd('syntax region OrangeText matchgroup=Conceal start="+O|" end="|+" concealends')
vim.cmd('syntax region CyanText matchgroup=Conceal start="+B|" end="|+" concealends')
vim.cmd('syntax region CeladonText matchgroup=Conceal start="+T|" end="|+" concealends')
require("mini.surround").config.custom_surroundings = {
  ["R"] = { output = { left = "+R|", right = "|+" } },
  ["G"] = { output = { left = "+G|", right = "|+" } },
  ["S"] = { output = { left = "+S|", right = "|+" } },
  ["Y"] = { output = { left = "+Y|", right = "|+" } },
  ["O"] = { output = { left = "+O|", right = "|+" } },
  ["B"] = { output = { left = "+B|", right = "|+" } },
  ["T"] = { output = { left = "+T|", right = "|+" } },
}

-------- Plugins ---------------------------------------------------------------

---- RenderMarkdown ------------------------------------------------------------
vim.g.render_markdown_config = {
  render_modes = true,
  completions = { lsp = { enabled = true } },
  checkbox = {
    checked = { icon = "󰫈", scope_highlight = "RenderMarkdownCheckedItem" },
    unchecked = { icon = "󰋙", scope_highlight = nil },
    custom = {
      todo = {
        raw = "[-]",
        rendered = "󰁘",
        highlight = "RenderMarkdownTodo",
        scope_highlight = "RenderMarkdownTodo",
      },
      sixth = { raw = "[a]", rendered = "󰫃", highlight = "RenderMarkdownBullet" },
      third = { raw = "[b]", rendered = "󰫄", highlight = "RenderMarkdownBullet" },
      half = { raw = "[o]", rendered = "󰫅", highlight = "RenderMarkdownBullet" },
      twothirds = { raw = "[d]", rendered = "󰫆", highlight = "RenderMarkdownBullet" },
      fivesix = { raw = "[e]", rendered = "󰫇", highlight = "RenderMarkdownBullet" },
      ongoing = { raw = "[@]", rendered = "󰛡", highlight = "Bg25Text", scope_highlight = "Bg25Text" },
      focus = { raw = "[!]", rendered = "", highlight = "DiagnosticError", scope_highlight = "DiagnosticError" },
      canceled = {
        raw = "[N]",
        rendered = "󰫊",
        highlight = "ScarletText",
        scope_highlight = "DiagnosticUnnecessary",
      },
    },
  },
  link = {
    footnote = { superscript = false },
    wiki = { scope_highlight = "RenderMarkdownWikiLinkText" },
  },
  bullet = { icons = { "󰆧" }, right_pad = 0 },
  pipe_table = {
    preset = "round",
    alignment_indicator = "┈",
  },
  heading = {
    position = "inline",
    -- icons = { " 󰉫 ", " 󰉬 ", " 󰉭 ", " 󰉮 ", " 󰉯 ", " 󰉰 " },
    -- icons = { " 󰇊 ", " 󰇋 ", " 󰇌 ", " 󰇍 ", " 󰇎 ", " 󰇏 " },
    icons = { " Ⅰ ", " Ⅱ ", " Ⅲ ", " Ⅳ ", " Ⅴ ", " Ⅵ " },
    -- icons = { " 🯱 ", " 🯲 ", " 🯳 ", " 🯴 ", " 🯵 ", " 🯶 " },
  },
  dash = {
    enabled = true,
    render_modes = false,
    icon = "─",
    width = "full",
    left_margin = 0,
  },
  latex = { enabled = false },
  html = { comment = { conceal = false } },
}

vim.g.bullets_checkbox_markers = " abodeX"
vim.g.bullets_set_mappings = 0
require("conform").formatters_by_ft.markdown = { "rumdl" }
vim.pack.add({
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/selimacerbas/markdown-preview.nvim" }, --FIX LLM
  { src = "https://github.com/selimacerbas/live-server.nvim" }, --FIX LLM
  { src = "https://github.com/bullets-vim/bullets.vim" }, --CHECKED: no LLMs
  { src = "https://github.com/chenxin-yan/footnote.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/Zeioth/markmap.nvim" }, --CHECKED: no LLMs
})

require("footnote").setup()
require("markdown_preview").setup({ mermaid_renderer = "js", scroll_sync = false })
require("markmap").setup({
  html_output = "/tmp/markmap.html",
  hide_toolbar = false,
  grace_period = 3600000,
})
