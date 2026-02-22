---- Options -------------------------------------------------------------------
vim.opt_local.spell = true -- spellcheck
vim.opt_local.shiftwidth = 2 -- ensures tabs == 2 whitespaces
vim.opt_local.textwidth = 0
vim.treesitter.start()
vim.cmd("digraph -- 8212")

---- Keymaps -------------------------------------------------------------------
-- make up/down consider wrapped text
local map = vim.keymap.set
map({ "n", "v" }, "k", "gk", { remap = false, buffer = true, silent = true })
map({ "n", "v" }, "j", "gj", { remap = false, buffer = true, silent = true })
map("n", "<leader>n", "<cmd>MkdnCreateFootnote<CR>", { remap = false, buffer = true, desc = "Create footnote" })
map("n", "o", "<cmd>MkdnNewListItemBelowInsert<CR>", { remap = false, buffer = true })
map("n", "O", "<cmd>MkdnNewListItemAboveInsert<CR>", { remap = false, buffer = true })
map("n", "<CR>", "<cmd>MkdnToggleToDo<CR>", { remap = false, buffer = true })
map("n", "gf", "<cmd>MkdnFollowLink<CR>", { remap = false, buffer = true })
-- Tables
require("which-key").add({
  { "<leader>i", group = "󰩵 Table insert" },
  { "<leader>x", group = "󰩶 Table delete" },
})
map({ "n", "i" }, "<Tab>", "<cmd>MkdnTableNextCell<CR>", { remap = false, buffer = true })
map({ "n", "i" }, "<S-Tab>", "<cmd>MkdnTablePrevCell<CR>", { remap = false, buffer = true })
map(
  "n",
  "<leader>ir",
  "<cmd>MkdnTableNewRowBelow<CR>",
  { remap = false, buffer = true, desc = "󰓳 Insert row below" }
)
map(
  "n",
  "<leader>iR",
  "<cmd>MkdnTableNewRowAbove<CR>",
  { remap = false, buffer = true, desc = "󰓴 Insert row above" }
)
map(
  "n",
  "<leader>ic",
  "<cmd>MkdnTableNewColAfter<CR>",
  { remap = false, buffer = true, desc = "󰓬 Insert column right" }
)
map(
  "n",
  "<leader>iC",
  "<cmd>MkdnTableNewColBefore<CR>",
  { remap = false, buffer = true, desc = "󰓭 Insert column left" }
)
map("n", "<leader>xc", "<cmd>MkdnTableDeleteCol<CR>", { remap = false, buffer = true, desc = "󰓮 Delete column" })
map("n", "<leader>xr", "<cmd>MkdnTableDeleteRow<CR>", { remap = false, buffer = true, desc = "󰓵 Delete row" })

---- Custom Syntax -------------------------------------------------------------
vim.cmd('syntax match Emdash "—" conceal cchar=𖢊')
vim.cmd('syntax region ScarletText matchgroup=Conceal start="+R|" end="|+" concealends')
vim.cmd('syntax region MossText matchgroup=Conceal start="+G|" end="|+" concealends')
vim.cmd('syntax region SandText matchgroup=Conceal start="+S|" end="|+" concealends')
vim.cmd('syntax region SaffronText matchgroup=Conceal start="+Y|" end="|+" concealends')
vim.cmd('syntax region OrangeText matchgroup=Conceal start="+O|" end="|+" concealends')
vim.cmd('syntax region CyanText matchgroup=Conceal start="+B|" end="|+" concealends')
vim.cmd('syntax region CeladonText matchgroup=Conceal start="+T|" end="|+" concealends')
require("mini.surround").config.custom_surroundings = {
  ["R"] = { output = { left = "+R|", right = "|+" } },
  ["G"] = { output = { left = "+R|", right = "|+" } },
  ["S"] = { output = { left = "+R|", right = "|+" } },
  ["Y"] = { output = { left = "+R|", right = "|+" } },
  ["O"] = { output = { left = "+R|", right = "|+" } },
  ["B"] = { output = { left = "+R|", right = "|+" } },
  ["T"] = { output = { left = "+R|", right = "|+" } },
}

---- LSP -----------------------------------------------------------------------
vim.lsp.enable({ "ltex_plus", "rumdl", "markdown_oxide" })

---- Plugins -------------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  -- { src = "https://github.com/bullets-vim/bullets.vim" },
  { src = "https://github.com/selimacerbas/live-server.nvim" },
  { src = "https://github.com/selimacerbas/markdown-preview.nvim" },
  { src = "https://github.com/jakewvincent/mkdnflow.nvim" },
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
          todo      = { raw = "[-]", rendered = "󰥔", highlight = "RenderMarkdownTodo" },
          -- sixth     = { raw = "[a]", rendered = "󰫃", highlight = "RenderMarkdownBullet" },
          -- third     = { raw = "[b]", rendered = "󰫄", highlight = "RenderMarkdownBullet" },
          -- half      = { raw = "[o]", rendered = "󰫅", highlight = "RenderMarkdownBullet" },
          -- twothirds = { raw = "[d]", rendered = "󰫆", highlight = "RenderMarkdownBullet" },
          -- fivesix   = { raw = "[e]", rendered = "󰫇", highlight = "RenderMarkdownBullet" },
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

---- bullets-vim -----------------------------------------------------------
-- vim.g.bullets_checkbox_markers = " abodeX"

---- footnotes -------------------------------------------------------------

require("mkdnflow").setup({
  modules = {
    bib = false,
    conceal = false,
    folds = false, --might be fun
    foldtext = false,
    maps = false,
    paths = false,
    notebook = false,
  },
  links = { auto_create = false },
  tables = { auto_extend_rows = true, cols = true },
  to_do = {
    statuses = {
      unchecked = { marker = " ", sort = { section = 1, position = "top" } },
      checked = { marker = { "X", "x" }, sort = { section = 2, position = "bottom" } },
    },
    status_order = { "unchecked", "checked" },
    status_propagation = { up = true, down = true },
    sort = {
      on_status_change = true,
      recursive = true,
      cursor_behavior = { track = false },
    },
  },
})
