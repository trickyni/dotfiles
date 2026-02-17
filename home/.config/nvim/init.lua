vim.pack.add({ "https://codeberg.org/trickyni/desert-witch.nvim" })
vim.cmd.colorscheme("desert-witch")
---- OPTIONS -------------------------------------------------------------------
--stylua: ignore start
vim.g.mapleader        = " " -- leader key (spacebar)
vim.g.have_nerd_font   = true
vim.opt.number         = true -- number column
vim.opt.relativenumber = true -- number column
vim.opt.ignorecase     = true -- search ignores case
vim.opt.smartcase      = true -- search ignores case unless uppercase letter exists
vim.opt.textwidth      = 100
vim.opt.wrap           = true
vim.opt.linebreak      = true
vim.opt.breakindent    = true
vim.opt.showbreak      = "> "
vim.opt.shiftwidth     = 2 -- indentation width
vim.opt.tabstop        = 2 -- tab width
vim.opt.softtabstop    = 2
vim.opt.expandtab      = true -- turns tabs into spaces
vim.opt.showmode       = false -- hides mode indicator, since we have a status line
vim.opt.laststatus     = 3
vim.opt.cursorline     = true -- highlights cursor line
vim.opt.scrolloff      = 10 -- keeps 10 lines above/below the cursor when scrolling
vim.opt.sidescrolloff  = 16 -- keeps 10 lines above/below the cursor when scrolling
vim.opt.signcolumn     = "yes:1" -- gutter to the left of the number column
vim.opt.inccommand     = "nosplit" -- shows find/replace results live
vim.opt.backspace      = { "start", "eol", "indent" }
vim.opt.list           = true -- show trailing whitespaces and tab characters
vim.opt.listchars      = { tab = "» ", trail = "·", nbsp = "␣", extends = "𖡺",conceal="𖠶" }
vim.opt.timeoutlen     = 300 --timeout on keys with followups
vim.opt.winborder      = "rounded" --border for floating windows
vim.opt.spelllang      = "en_us"
vim.opt.smoothscroll   = true
vim.opt.splitright     = true
vim.opt.undofile       = true
vim.o.conceallevel     = 2
vim.o.concealcursor    = "" 
vim.opt.shortmess:append("Swl")
--stylua: ignore end
---- KEYMAPS -------------------------------------------------------------------
-- Buffer Navigation
vim.keymap.set("n", "<C-n>", "<cmd>enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<C-]>", "<cmd>bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-[>", "<cmd>bp<CR>", { desc = "Prev buffer" })
-- Wrap-aware movement
vim.keymap.set({ "n", "v" }, "<Up>", "gk", { remap = false, silent = true })
vim.keymap.set({ "n", "v" }, "<Down>", "gj", { remap = false, silent = true })
vim.keymap.set("i", "<Up>", "<C-o>gk", { remap = false, silent = true })
vim.keymap.set("i", "<Down>", "<C-o>gj", { remap = false, silent = true })
-- Line Moving
vim.keymap.set("n", "<S-Down>", ":m .+1<CR>==", { desc = "Move line up", remap = false, silent = true })
vim.keymap.set("n", "<S-Up>", ":m .-2<CR>==", { desc = "Move line down", remap = false, silent = true })
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line up", remap = false, silent = true })
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line down", remap = false, silent = true })
vim.keymap.set("n", "<S-Right>", ">>", { desc = "Move line right", remap = false, silent = true })
vim.keymap.set("n", "<S-Left>", "<<", { desc = "Move line left", remap = false, silent = true })
vim.keymap.set("v", "<S-Right>", ">gv", { desc = "Move line right", remap = false, silent = true })
vim.keymap.set("v", "<S-Left>", "<gv", { desc = "Move line left", remap = false, silent = true })
-- Other
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "clear highlights" })
vim.keymap.set("n", "<CR>", "<cmd>ToggleCheckbox<CR>", { desc = "Toggle Checkbox" })
vim.keymap.set("n", "<C-/>", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show floating diagnostic" })
vim.keymap.set("n", "<leader><leader>", "<cmd>ZenMode<CR>", { desc = "Zen mode" })
vim.keymap.set({ "n", "v" }, "<Bslash>", "<cmd>Yazi<CR>", { desc = "yazi" })
vim.keymap.set({ "n", "x" }, "<leader>s", "<Cmd>RipSubstitute<CR>", { desc = "Find/Replace" })
vim.keymap.set("n", "<leader>d", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>r", "<cmd>lua Snacks.picker.recent()<CR>", { desc = "Recent Files" })
vim.keymap.set("n", "<leader>p", "<cmd>lua Snacks.picker.projects()<CR>", { desc = "Projects" })
vim.keymap.set("n", "<leader>m", "<cmd>lua Snacks.picker.man()<CR>", { desc = "Man-pages" })
vim.keymap.set("n", "<leader>t", "<cmd>lua Snacks.picker.todo_comments()<CR>", { desc = "Todo" })
vim.keymap.set({ "n", "v" }, '<leader>"', "<cmd>lua Snacks.picker.registers()<CR>", { desc = "Registers" })
vim.keymap.set("n", "<leader>g", "<cmd>Gitsigns toggle_linehl<CR>", { desc = "Toggle Diff" })

---- Behaviors -----------------------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", { --highlights text on yank
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.schedule(function() -- sync OS/nvim clipboards
  vim.o.clipboard = "unnamedplus"
end)

---- Diagnostic configs --------------------------------------------------------
vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅜 ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "󰋼 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
  update_in_insert = true,
  inlay_hints = true,
  jump = {
    on_jump = function(diagnostic, bufnr)
      if not diagnostic then
        return
      end
      vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
    end,
  },
})

---- Plugins -------------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/bullets-vim/bullets.vim" },
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/folke/zen-mode.nvim" },
  { src = "https://github.com/nvim-mini/mini.surround" },
  { src = "https://github.com/nvim-mini/mini.comment" },
  { src = "https://github.com/nvim-mini/mini.align" },
  { src = "https://github.com/nvim-mini/mini.splitjoin" },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.tabline" },
  { src = "https://github.com/abecodes/tabout.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/karb94/neoscroll.nvim" },
  { src = "https://github.com/chrisgrieser/nvim-rip-substitute" },
  { src = "https://github.com/mikavilpas/yazi.nvim" },
  { src = "https://github.com/smjonas/live-command.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/MahanRahmati/blink-nerdfont.nvim" },
  { src = "https://github.com/moyiz/blink-emoji.nvim" },
  { src = "https://github.com/dimtion/guttermarks.nvim" },
})

require("mini.pairs").setup()
require("mini.comment").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.align").setup()
require("tabout").setup({ tabkey = "<Tab>" })
require("rip-substitute").setup({ popupWin = { border = "rounded" } })
require("gitsigns").setup({ signs = { delete = "─" } })
require("live-command").setup({
  commands = { Norm = { cmd = "norm" }, G = { cmd = "g" } },
  inline_highlighting = false,
})
vim.cmd("cnoreabbrev norm Norm")
vim.cmd("cnoreabbrev g G")

require("neoscroll").setup({ easing = "sine" })
require("yazi").setup({ yazi_floating_window_border = "rounded" })
require("trouble").setup({ focus = true, multiline = true, keys = { ["<esc>"] = "close" } })

--stylua: ignore
vim.lsp.enable({
  "lua_ls",    --lua
  "ts_ls",     --Javascript/typescript
  "bashls",    --Bash
  "qmlls",     --QML
  "tombi",     --TOML FIX
  "ltex_plus", --plaintext, markdown
  "rumdl",     --Markdown
})

---- conform.nvim --------------------------------------------------------------
--stylua: ignore
require("conform").setup({
  format_on_save = true,
  formatters_by_ft = {
    sh         = { "shfmt" },
    lua        = { "stylua" },
    javascript = { "prettier" },
    markdown   = { "rumdl" },
    html       = { "prettier" },
    css        = { "prettier" },
    yaml       = { "prettier" },
    json       = { "prettier" },
    qml        = { "prettier" },
    toml       = { "tombi" },
  },
  formatters   = {
    stylua     = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } },
    shfmt      = { prepend_args = { "-i = 2" } },
    prettier   = { prepend_args = { "--tab-width", "2" ,"--experimental-ternaries","false"} },
  },
})

---- treesitter ----------------------------------------------------------------
require("nvim-treesitter").setup({
  highlight = { enable = true },
  -- stylua: ignore
  ensure_installed = {
    "bash", "caddy", "css",  "csv",    "diff",     "dockerfile",      "html",  "javascript",
    "jq",   "json",  "jsx",  "lua",    "markdown", "markdown_inline", "qmljs", "regex", "sql",
    "toml", "typst", "sway", "vimdoc", "yaml",     "rust",            "ron",
  },
})

---- MARKDOWN -------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", { -- Markdown-specific
  pattern = "markdown",
  callback = function(args)
    vim.treesitter.start(args.buf, "markdown") -- activates the markdown treesitter
    vim.opt_local.spell = true -- spellcheck
    vim.opt_local.shiftwidth = 2 -- ensures tabs == 2 whitespaces
    vim.opt_local.textwidth = 0
    -- make up/down consider wrapped text
    vim.keymap.set({ "n", "v" }, "k", "gk", { remap = false, buffer = true, silent = true })
    vim.keymap.set({ "n", "v" }, "j", "gj", { remap = false, buffer = true, silent = true })
    vim.cmd('syntax match Emdash "—" conceal cchar=𖢊')
    vim.cmd('syntax region EditNote start="|NOTE" end="||" conceal cchar=𖡗')
    vim.api.nvim_set_hl(0, "EditNote", { fg = "#e86045", bg = "#3b3228" })
    vim.cmd('syntax region MossText matchgroup=Conceal start="+G{" end="}+" concealends')
    vim.cmd('syntax region ScarletText matchgroup=Conceal start="+R{" end="}+" concealends')
    vim.cmd('syntax region SandText matchgroup=Conceal start="+S{" end="}+" concealends')
    vim.cmd('syntax region SaffronText matchgroup=Conceal start="+Y{" end="}+" concealends')
    vim.cmd('syntax region OrangeText matchgroup=Conceal start="+O{" end="}+" concealends')
    vim.cmd('syntax region CyanText matchgroup=Conceal start="+B{" end="}+" concealends')
    vim.cmd('syntax region CeladonText matchgroup=Conceal start="+T{" end="}+" concealends')
    vim.cmd("digraph -- 8212")

    ---- RenderMarkdown --------------------------------------------------------
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
      -- wiki = { scope_highlight = "RenderMarkdownWikiLinkText" },
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

    ---- bullets-vim -----------------------------------------------------------
    vim.g.bullets_checkbox_markers = " abodeX"
  end,
})
---- blink.cmp -----------------------------------------------------------------
require("blink.cmp").setup({
  keymap = { preset = "enter", ["<Tab>"] = { "select_next" }, ["<S-Tab>"] = { "select_prev" } },
  fuzzy = { implementation = "prefer_rust", prebuilt_binaries = { force_version = "0.6.0" } },
  appearance = { nerd_font_variant = "mono" },
  completion = {
    accept = { auto_brackets = { enabled = true } },
    documentation = { auto_show = true },
  },
  sources = {
    default = { "lsp", "path", "snippets", "nerdfont", "emoji" },
    providers = {
      nerdfont = {
        module = "blink-nerdfont",
        name = "Nerd Fonts",
        score_offset = 15, -- Tune by preference
        opts = { insert = true, trigger = ";" }, -- Insert nerdfont icon (default) or complete its name
      },
      emoji = {
        module = "blink-emoji",
        name = "Emoji",
        score_offset = 15, -- Tune by preference
        opts = { insert = true, trigger = ":" },
      },
    },
  },
  cmdline = { enabled = true },
  signature = { enabled = false },
})
---- which-key -----------------------------------------------------------------
require("which-key").setup({
  preset = "helix",
  plugins = { presets = { motions = false, text_objects = false, operators = false } },
  icons = { rules = false, separator = "→" },
})
require("which-key").add({
  { "gN", desc = "Renumber bullet list" },
  { "gS", desc = "mini.splitjoin Toggle" },
})

---- todo-comments -------------------------------------------------------------
require("todo-comments").setup({
  keywords = {
    FIX = { icon = "󰅜" },
    HACK = { icon = "" },
    PERF = { icon = "" },
    TODO = { icon = "" },
    INFO = { icon = "󰋼" },
  },
  highlight = { keyword = "bg", after = "", pattern = [[.*<(KEYWORDS)\s*]] },
  search = { pattern = [[\b(KEYWORDS)]] },
})

---- colorizer -----------------------------------------------------------------
require("colorizer").setup({
  lazy_load = true,
  user_default_options = {
    names = false,
    --stylua: ignore
    names_custom = {
      bg      = "#3b3228",
      bg95    = "#43392d",
      bg75    = "#4c4134",
      altbg   = "#5d4f40",
      bg25    = "#6b6055",
      sand    = "#c1a387",
      fg      = "#afd2e9",
      orange  = "#e68d53",
      saffron = "#f8e2a0",
      scarlet = "#e86045",
      moss    = "#92a650",
      celadon = "#ace1af",
      cyan    = "#3eccbe",
      grey    = "#868686",
      nazar   = "#15156b",
    },
  },
})

---- mini.tabline --------------------------------------------------------------
require("mini.tabline").setup({
  format = function(buf_id, label)
    local suffix = vim.bo[buf_id].modified and "+ " or ""
    return MiniTabline.default_format(buf_id, label) .. suffix
  end,
})

---- lualine -------------------------------------------------------------------
require("lualine").setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "🭑", right = "🭔" },
  },
  sections = {
    lualine_b = {
      { "filename", path = 0, symbols = { modified = "", readonly = { "", color = { fg = "#e86045" } } } },
      { "branch", color = { fg = "#92a650" }, icon = { "𖣂", color = { fg = "#92a650" } }, padding = 0 },
      { "diff", padding = { left = 1, right = 1 } },
    },
    lualine_c = {
      {
        "diagnostics",
        padding = 1,
        symbols = { error = "󰅜", warn = "", info = "󰋼", hint = "󰌶" },
      },
    },
    lualine_x = {
      {
        "lsp_status",
        color = "OkMsg",
        padding = 1,
        icon = { "", align = "right" },
        symbols = { done = "", spinner = "", separator = ", " },
        show_name = true,
      },
    },
    lualine_y = { { "filetype", colored = false } },
    lualine_z = { "progress", "searchcount", "location" },
  },
})

---- rainbow-delimiters --------------------------------------------------------
vim.g.rainbow_delimiters = {
  highlight = { "RainbowDelimiterRed", "RainbowDelimiterYellow", "RainbowDelimiterBlue", "RainbowDelimiterOrange" },
  blacklist = { "html" },
}

---- Zen-Mode ------------------------------------------------------------------
require("zen-mode").setup({
  window = { width = 100, backdrop = 1 },
  plugins = { options = { laststatus = 0 }, gitsigns = { enabled = true } },
  -- on_open = function()
  --   vim.cmd("Gitsigns toggle_signs")
  -- end,
  -- on_close = function()
  --   vim.cmd("Gitsigns toggle_signs")
  -- end,
})

---- Snacks --------------------------------------------------------------------
require("snacks").setup({
  dashboard = {
    enabled = true,
    width = 40,
    preset = {
      --stylua: ignore
      keys = {
        { icon = " ", key = "n",  desc = "New File",     action  = ":ene | startinsert" },
      --   { icon = " ", key = "\\", desc = "File Explorer", action = ":Yazi" },
        { icon = " ", key = "r",  desc = "Recent Files", action  = ":lua Snacks.picker.recent()" },
      --   { icon = " ", key = "p",  desc = "Projects",     action  = ":lua Snacks.picker.projects()" },
        { icon = " ", key = "q",  desc = "Quit",         action  = ":qa" },
      },
      header = {
        [[
  ,-.       _,---._ __  / \
 /  )    .-'       `./ /   \
(  (   ,'            `/    /|
 \  `-"             \'\   / |
   /`.          ,'-`----Y   |
   `.              ,  \ \ /  |
  (            ;        |   '
  |  ,-.    ,-'         |  /
  |  | (   |            | /
  )  |  \  `.___________|/
  `--'   `--'
]],
      },
    },
    sections = {
      { section = "header", indent = 5 },
      { section = "recent_files", indent = 2, padding = 1 },
      { section = "keys", indent = 2, padding = 1 },
    },
  },
  indent = {
    indent = { char = "▏" },
    animate = { enabled = false },
    scope = { enabled = false },
  },
  picker = {
    sources = {
      man = { layout = "select" },
      recent = { layout = "select" },
      registers = {
        layout = { preview = false, preset = "right" },
        preview = false,
        confirm = { "paste", "close" },
      },
      projects = {
        filter = { paths = { ["~/.local/share/nvim/"] = false } },
        dev = "~/git",
        layout = "default",
        projects = {
          "~/.config/nvim",
          "~/.config/rmpc",
          "~/.config/sway",
        },
      },
      todo_comments = { buffers = true, layout = "select" },
    },
  },
})
