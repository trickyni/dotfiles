---- Options -------------------------------------------------------------------
vim.opt_local.spell = true -- spellcheck
vim.opt_local.shiftwidth = 2 -- ensures tabs == 2 whitespaces
vim.opt_local.textwidth = 0
vim.opt_local.foldtext = ""
-- vim.fn.setcellwidths({ { 0x2014, 0x2014, 2 } })
vim.cmd("digraph -- 8212")

---- Treesitter ---------------------------------------------------------------
require("nvim-treesitter").install({ "markdown", "markdown_inline", "yaml" })
vim.treesitter.start()
vim.bo.syntax = "on"

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
-- map("n", "o", "<cmd>Checkmate create<CR>", { remap = false, buffer = true })
map("i", "<C-->", "—")
require("mini.keymap").map_combo("i", "<C--><C-->", "<BS><BS>–", { delay = 300 })
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
map("n", "z1", "<cmd>set foldlevel=0<CR>", { buffer = true, desc = "Fold headers to h1" })
map("n", "z2", "<cmd>set foldlevel=1<CR>", { buffer = true, desc = "Fold headers to h2" })
map("n", "z3", "<cmd>set foldlevel=2<CR>", { buffer = true, desc = "Fold headers to h3" })
map("n", "z4", "<cmd>set foldlevel=3<CR>", { buffer = true, desc = "Fold headers to h4" })
map("n", "z5", "<cmd>set foldlevel=4<CR>", { buffer = true, desc = "Fold headers to h5" })

---- Custom Syntax -------------------------------------------------------------
vim.schedule(function()
  vim.cmd('syntax region ScarletText matchgroup=Conceal start="+R|" end="|+" concealends')
  vim.cmd('syntax region MossText matchgroup=Conceal start="+G|" end="|+" concealends')
  vim.cmd('syntax region SandText matchgroup=Conceal start="+S|" end="|+" concealends')
  vim.cmd('syntax region SaffronText matchgroup=Conceal start="+Y|" end="|+" concealends')
  vim.cmd('syntax region OrangeText matchgroup=Conceal start="+O|" end="|+" concealends')
  vim.cmd('syntax region CyanText matchgroup=Conceal start="+B|" end="|+" concealends')
  vim.cmd('syntax region CeladonText matchgroup=Conceal start="+T|" end="|+" concealends')
  vim.cmd('syntax region Bg25Text matchgroup=Conceal start="+F|" end="|+" concealends')
  vim.cmd('syntax region GreyText matchgroup=Conceal start="+E|" end="|+" concealends')
  vim.cmd("syntax region tokiPonaLongGlyph start=/%U000f1997/ end=/%U000f1998/ concealends")
end)
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
vim.api.nvim_set_hl(0, "tokiPonaLongGlyph", { fg = "#e68d53", underline = true })
-- vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = "#afd2e9", bg = "#3b3228" })

---- RenderMarkdown ------------------------------------------------------------
vim.g.render_markdown_config = {
  -- anti_conceal = { enabled = false },
  render_modes = true,
  completions = { lsp = { enabled = true } },
  checkbox = {
    checked = { icon = "󰫈", highlight = "Bg25Text" }, --, scope_highlight = "RenderMarkdownCheckedItem" },
    unchecked = { icon = "󰋙" }, -- scope_highlight = nil },
    custom = {
      ongoing = { raw = "[-]", rendered = "󰁘", highlight = "CeladonText" },
      pending = { raw = "[@]", rendered = "󱃲", highlight = "MossText" },
      cancelled = { raw = "[#]", rendered = "󰫊", highlight = "ScarletText" },
      important = { raw = "[!]", rendered = "", highlight = "DiagnosticError" },
      -- sixth = { raw = "[a]", rendered = "󰫃", highlight = "RenderMarkdownBullet" },
      -- third = { raw = "[b]", rendered = "󰫄", highlight = "RenderMarkdownBullet" },
      -- half = { raw = "[o]", rendered = "󰫅", highlight = "RenderMarkdownBullet" },
      -- twothirds = { raw = "[d]", rendered = "󰫆", highlight = "RenderMarkdownBullet" },
      -- fivesix = { raw = "[e]", rendered = "󰫇", highlight = "RenderMarkdownBullet" },
    },
  },
  link = {
    -- footnote = { superscript = false },
    highlight = "RenderMarkdownLink",
    wiki = {
      highlight = "RenderMarkdownWikiLink",
      scope_highlight = nil,
      icon = "",
    },
    image = "",
    custom = {
      audio = { icon = " ", pattern = "^!%[%[.*%.m[4p][a3]$", kind = "file", highlight = "RenderMarkdownLink" },
      video = { icon = " ", pattern = "^!%[%[.*%.m[pk][4v]$", kind = "file", highlight = "RenderMarkdownLink" },
      webm = { icon = " ", pattern = "%.webm$", kind = "file", highlight = "RenderMarkdownLink" },
      wikipedia = { icon = "󰖬", pattern = "wikipedia%.org", kind = "url", highlight = "SandText" },
      admin = { icon = " ", pattern = "^0[02346789]%.%d%d", kind = "pattern", highlight = "SandText" },
      medical = { icon = "󰶯 ", pattern = "^05%.%d%d", kind = "pattern", highlight = "SandText" },
      wisdom = { icon = "󰟶 ", pattern = "^1[0-9]%.%d%d", kind = "pattern", highlight = "SandText" },
      writing = { icon = " ", pattern = "^2[0-9]%.%d%d", kind = "pattern", highlight = "SandText" },
      creative = { icon = " ", pattern = "^5[0-9]%.%d%d", kind = "pattern", highlight = "SandText" },
      studies = { icon = " ", pattern = "^6[03456789]%.%d%d", kind = "pattern", highlight = "SandText" },
      voice = { icon = "󰗋 ", pattern = "^62%.%d%d", kind = "pattern", highlight = "SandText" },
      language = { icon = "󰗊 ", pattern = "^61%.[03456789]%d", kind = "pattern", highlight = "SandText" },
      japanese = { icon = "󱌴 ", pattern = "^61%.1%d", kind = "pattern", highlight = "SandText" },
      tokipona = { icon = "󱥬", pattern = "^61%.2%d", kind = "pattern", highlight = "SandText" },
      tech = { icon = " ", pattern = "^7[0-9]%.%d%d", kind = "pattern", highlight = "SandText" },
    },
  },
  -- bullet = { enabled = false },
  bullet = { icons = { "󰆧" }, right_pad = 0 },
  pipe_table = {
    preset = "round",
    alignment_indicator = "┈",
  },
  heading = {
    setext = false,
    position = "inline",
    signs = { false },
    icons = { " 󰇊 ", " 󰇋 ", " 󰇌 ", " 󰇍 ", " 󰇎 ", " 󰇏 " },
    -- icons = { " Ⅰ ", " Ⅱ ", " Ⅲ ", " Ⅳ ", " Ⅴ ", " Ⅵ " },
    -- icons = { " 󰉫 ", " 󰉬 ", " 󰉭 ", " 󰉮 ", " 󰉯 ", " 󰉰 " },
    -- icons = { " 🯱 ", " 🯲 ", " 🯳 ", " 🯴 ", " 🯵 ", " 🯶 " },
  },
  dash = {
    enabled = true,
    render_modes = false,
    icon = "─",
    width = "full",
    left_margin = 0,
  },
  code = {
    language_icon = true,
    language_name = true,
    language_info = true,
    width = "block",
    left_pad = 2,
    inline_left = ">",
    border = "thin",
  },
  callout = {
    note = {
      raw = "[!WIP]",
      rendered = "󱌣 Under Construction",
      highlight = "RenderMarkdownWarn",
      category = "custom",
    },
  },
  latex = { enabled = false },
  html = { comment = { conceal = false } },
}

-- vim.g.bullets_checkbox_markers = " abodeX"
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
