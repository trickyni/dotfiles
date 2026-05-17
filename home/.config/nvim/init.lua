---- COLORSCHEME ---------------------------------------------------------------
vim.pack.add({ "https://codeberg.org/trickyni/desert-witch.nvim" })
vim.cmd.colorscheme("desert-witch")
---- OPTIONS -------------------------------------------------------------------
--stylua: ignore start
vim.opt.termguicolors  = true
vim.g.mapleader        = " "  -- leader key (spacebar)
vim.g.maplocalleader   = " "  -- leader key (spacebar)
vim.g.have_nerd_font   = true
vim.opt.number         = true -- number column
vim.opt.relativenumber = true -- number column
vim.opt.ignorecase     = true -- search ignores case
vim.opt.smartcase      = true -- search ignores case unless uppercase letter exists
vim.opt.textwidth      = 80
vim.opt.wrap           = true
vim.opt.linebreak      = true
vim.opt.breakindent    = true
vim.opt.showbreak      = "> "
vim.opt.shiftwidth     = 2         -- indentation width
vim.opt.tabstop        = 2         -- tab width
vim.opt.softtabstop    = 2
vim.opt.expandtab      = true      -- turns tabs into spaces
vim.opt.showmode       = false     -- hides mode indicator, since we have a status line
vim.opt.laststatus     = 3
vim.opt.cursorline     = true      -- highlights cursor line
vim.opt.scrolloff      = 10        -- keeps 10 lines above/below the cursor when scrolling
vim.opt.sidescrolloff  = 16        -- keeps 10 lines above/below the cursor when scrolling
vim.opt.signcolumn     = "yes:1"   -- gutter to the left of the number column
vim.opt.inccommand     = "nosplit" -- shows find/replace results live
vim.opt.backspace      = { "start", "eol", "indent" }
vim.opt.list           = true      -- show trailing whitespaces and tab characters
vim.opt.listchars      = { tab = "» ", trail = "·", nbsp = "␣"}
vim.opt.timeoutlen     = 300       --timeout on keys with followups
vim.opt.winborder      = "rounded" --border for floating windows
vim.opt.pumborder      = "rounded" --border for popup menus
vim.opt.spelllang      = "en_us"
vim.opt.smoothscroll   = true
vim.opt.splitright     = true
vim.opt.undofile       = true
vim.opt.shortmess:append("Swl")
--stylua: ignore end
---- KEYMAPS -------------------------------------------------------------------
local map = vim.keymap.set
-- Buffer Navigation
map("n", "<C-n>", "<cmd>enew<CR>", { desc = "New buffer" })
map("n", "<C-]>", "<cmd>bn<CR>", { desc = "Next buffer" })
map("n", "<C-[>", "<cmd>bp<CR>", { desc = "Prev buffer" })
-- Wrap-aware movement
map({ "n", "v" }, "<Up>", "gk", { remap = false, silent = true })
map({ "n", "v" }, "<Down>", "gj", { remap = false, silent = true })
map("i", "<Up>", "<C-o>gk", { remap = false, silent = true })
map("i", "<Down>", "<C-o>gj", { remap = false, silent = true })
-- Line Moving
map("n", "<S-Down>", ":m .+1<CR>==", { desc = "Move line up", remap = false, silent = true })
map("n", "<S-Up>", ":m .-2<CR>==", { desc = "Move line down", remap = false, silent = true })
map("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line up", remap = false, silent = true })
map("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line down", remap = false, silent = true })
map("n", "<S-Right>", ">>", { desc = "Move line right", remap = false, silent = true })
map("n", "<S-Left>", "<<", { desc = "Move line left", remap = false, silent = true })
map("v", "<S-Right>", ">gv", { desc = "Move line right", remap = false, silent = true })
map("v", "<S-Left>", "<gv", { desc = "Move line left", remap = false, silent = true })
-- rebind Shift+left/right to Ctrl+left/right
map("n", "<C-Right>", "w", { remap = false, silent = true })
map("n", "<C-Left>", "b", { remap = false, silent = true })
map("i", "<C-Right>", "<S-Right>", { remap = false, silent = true })
map("i", "<C-Left>", "<S-Left>", { remap = false, silent = true })
-- bottom of the file and center screen
map("n", "G", "Gzz", { remap = false, silent = true })
-- Other
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "clear highlights" })
map("n", "ycc", "yygccp", { remap = true, desc = "Duplicate line and comment original" })
map("n", "<C-'>", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show floating diagnostic" })
map("n", "<leader><leader>", "<cmd>ZenMode<CR>", { desc = "Zen mode" })
map({ "n", "v" }, "<Bslash>", "<cmd>Yazi<CR>")
map({ "n", "v" }, "<C-Bslash>", "<cmd>lua Snacks.picker.explorer()<CR>")
map({ "n", "x" }, "<leader>s", "<Cmd>RipSubstitute<CR>", { desc = "Find/Replace" })
map("n", "<leader>d", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
map("n", "<leader>r", "<cmd>lua Snacks.picker.recent()<CR>", { desc = "Recent Files" })
map("n", "<leader>p", "<cmd>lua Snacks.picker.projects()<CR>", { desc = "Projects" })
map("n", "<leader>f", "<cmd>GrugFar<CR>", { desc = "Grug-Far" })
map("n", "<leader>g", "<cmd>Gitsigns toggle_linehl<CR>", { desc = "Toggle Diff" })
map("n", "grf", "<cmd>lua require('conform').format()<CR>", { desc = "Format buffer" })
map("n", "grl", "<cmd>Trouble lsp_references<CR>", { desc = "references" })
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "LSP go to definition" })
map("n", "<leader>ot", "<cmd>Journal <CR>", { desc = "Today's daily note" })
map("n", "<leader>on", "<cmd>Journal +1<CR>", { desc = "Tomorrow's daily note" })
map("n", "<leader>oy", "<cmd>Journal -1<CR>", { desc = "Yesterday's daily note" })
map("n", "<leader>of", "<cmd>Obsidian quick_switch<CR>", { desc = "Pick from vault" })
map("n", "<leader>o#", "<cmd>Obsidian tags<CR>", { desc = "Pick from vault" })

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
  underline = { severity = vim.diagnostic.severity.WARN },
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
  { src = "https://github.com/neovim/nvim-lspconfig" }, --INFO one copilot commit
  { src = "https://github.com/nvim-lua/plenary.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-mini/mini.surround" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-mini/mini.comment" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-mini/mini.align" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-mini/mini.splitjoin" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-mini/mini.pairs" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-mini/mini.tabline" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-mini/mini.snippets" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-mini/mini.completion" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-mini/mini.keymap" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-mini/mini.icons" }, --CHECKED: no LLMs
  { src = "https://github.com/folke/todo-comments.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/folke/zen-mode.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/folke/which-key.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/folke/trouble.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/folke/snacks.nvim" }, --FIX: LLM DETECTED
  { src = "https://github.com/catgoose/nvim-colorizer.lua" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-tree/nvim-web-devicons" }, --CHECKED: no LLMs
  { src = "https://github.com/lewis6991/gitsigns.nvim" }, --FIX llm use
  { src = "https://github.com/karb94/neoscroll.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/chrisgrieser/nvim-rip-substitute" }, --CHECKED: no LLMs
  { src = "https://github.com/mikavilpas/yazi.nvim" }, --WARN LLM usage
  { src = "https://github.com/smjonas/live-command.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" }, --CHECKED: no LLMs
  { src = "https://github.com/nvim-lualine/lualine.nvim" }, --CHECKED: no LLMs
  { src = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/stevearc/conform.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/dimtion/guttermarks.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/cosmicbuffalo/eyeliner.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/tpope/vim-abolish" }, --CHECKED: no LLMs
  { src = "https://github.com/obsidian-nvim/obsidian.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/MagicDuck/grug-far.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/jakobkhansen/journal.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/saghen/blink.lib" },
  { src = "https://github.com/saghen/blink.cmp" },
})
require("plugins.pack-ui")
require("mini.pairs").setup()
require("mini.icons").setup()
require("mini.comment").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.align").setup()
require("eyeliner").setup({ dim = true, disabled_buftypes = { "nofile" } })
require("rip-substitute").setup({ prefill = { normal = false } })
require("gitsigns").setup({ signs = { delete = "─" } })
require("yazi").setup({ yazi_floating_window_border = "rounded", open_for_directories = true })
require("trouble").setup({ focus = true, multiline = true, keys = { ["<esc>"] = "close" } })
require("colorizer").setup({ options = { parsers = { names = { enable = false } } } })
require("neoscroll").setup({ easing = "sine", use_local_scrolloff = true })
map("n", "<PageUp>", "<cmd>lua require('neoscroll').ctrl_u({duration=300})<CR>", { remap = true })
map("n", "<PageDown>", "<cmd>lua require('neoscroll').ctrl_d({duration=300})<CR>", { remap = true })
require("grug-far").setup({
  keymaps = {
    replace = { n = "<C-CR>" },
    close = { n = "q" },
  },
})
require("live-command").setup({
  enable_highlighting = true,
  inline_highlighting = true,
  commands = {
    Norm = { cmd = "normal" },
    Glo = { cmd = "global" },
  },
})
vim.cmd("cnoreabbrev norm Norm")
vim.cmd("cnoreabbrev normal Normal")
vim.cmd("cnoreabbrev glo Glo")
vim.cmd("cnoreabbrev global Global")

---- mini.keymap ---------------------------------------------------------------
--stylua: ignore start
local n_cr_steps = {}
n_cr_steps[1] = {
  condition = function() return vim.bo.filetype == "markdown" end,
  action = function() return "<cmd>ToggleCheckbox<CR>j" end,
}
n_cr_steps[2] = {
  condition = function() return require("obsidian.api").cursor_link() end,
  action = function() return "<cmd>Obsidian follow_link<CR>" end,
}
n_cr_steps[3] = {
  condition = function() return require("obsidian.api").cursor_tag() end,
  action = function() return "<cmd>Obsidian tags<CR>" end,
}

local i_cr_steps = {"blink_accept",nil,"minipairs_cr"}
i_cr_steps[2] = {
  condition = function() return vim.bo.filetype == "markdown" end,
  action = function() return "<cmd>InsertNewBullet<CR>" end,
}

local multistep = require("mini.keymap").map_multistep
multistep("i", "<Tab>", { "minisnippets_next", "minisnippets_expand", "blink_next", "jump_after_close" })
multistep("i", "<S-Tab>", { "minisnippets_prev", "blink_prev", "jump_before_open" })
multistep("i", "<BS>", { "minipairs_bs" })
multistep("i", "<CR>", i_cr_steps)
multistep("n", "<CR>", n_cr_steps)
--stylua: ignore end
local combo = require("mini.keymap").map_combo
combo("i", "((", "<BS><BS>(", { delay = 300 })
combo("i", "[[", "<BS><BS>[", { delay = 300 })
combo("i", "{{", "<BS><BS>{", { delay = 300 })
combo("i", '""', '<BS><BS>"', { delay = 300 })
combo("i", "''", "<BS><BS>'", { delay = 300 })
combo("i", "``", "<BS><BS>`", { delay = 300 })

---- conform.nvim --------------------------------------------------------------
require("conform").setup({
  log_level = vim.log.levels.TRACE,
  format_on_save = true,
  --stylua: ignore
  formatters_by_ft = {
    html       = { "prettier" },
    css        = { "prettier" },
    yaml       = { "prettier" },
    json       = { "prettier" },
  },
  formatters = {
    prettier = {
      prepend_args = { "--tab-width", "2" },
    },
  },
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

---- treesitter ----------------------------------------------------------------
require("nvim-treesitter").setup({
  highlight = { enable = true },
})
--stylua: ignore
require("nvim-treesitter").install({
  "caddy", "css", "csv", "desktop", "diff", "dockerfile", "editorconfig", "git_config", "git_rebase", "gitcommit", "gitignore", "html", "jq", "kitty", "regex", "robots_txt", "sql", "tmux", "typst", "sway", "vimdoc", "xml", "yaml",
})
---- mini.snippets -------------------------------------------------------------
local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup({
  snippets = {
    -- gen_loader.from_file("~/.config/nvim/snippets/global.json"),
    gen_loader.from_lang(),
  },
  mappings = { stop = "<C-c>" },
})
MiniSnippets.start_lsp_server({ match = false })

---- obsidian.nvim -------------------------------------------------------------
vim.g.obsidian_default_keymap = false
require("obsidian").setup({
  workspaces = { { name = "Documents", path = "~/Documents", strict = true } },
  footer = { format = "{{words}} words  {{backlinks}} backlinks" },
  note_id_func = require("obsidian.builtin").title_id,
  ui = { enable = false },
  legacy_commands = false,
  checkbox = { enabled = false },
  daily_notes = { enabled = false },
})

---- journal.nvim --------------------------------------------------------------
local weekday_format = "%Y/%m-%B/daily/%Y-%m-%d__%A"
local weekday_template =
  "---\nid: %Y-%m-%d__%A\naliases: []\ntags:\n - daily-notes\n---\n\n# %Y-%m-%d__%A\n\n## Achievements\n\n## Reflect\n\n## Do\n\n## Observations\n\n## Gratitude\n"
require("journal").setup({
  filetype = "md",
  root = "~/Documents/journal",
  date_format = "%Y-%m-%d",
  autocomplete_date_modifier = "end",
  journal = { --Default journal format (same as day)
    format = weekday_format,
    template = weekday_template,
    frequency = { day = 1 },
    entries = {
      sun = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "last sunday",
      },
      mon = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "monday",
      },
      tue = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "tuesday",
      },
      wed = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "wednesday",
      },
      thu = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "thursday",
      },
      fri = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "friday",
      },
      sat = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "saturday",
      },
      week = {
        format = function(date)
          local this_week = date:relative({ day = 7 })
          local week_nr = os.date("%U", os.time(this_week.date))
          return "%Y/%m-%B/weekly/%Y-w" .. week_nr
        end,
        template = function(date)
          local this_sat = date:relative({ day = 6 })
          local week_end = os.date("%b %-d", os.time(this_sat.date))
          local week_nr = tonumber(os.date("%U", os.time(this_sat.date)) + 1)
          return "# Week " .. week_nr .. " - %b %-d -> " .. week_end .. "\n"
        end,
        frequency = { day = 7 },
        date_modifier = "last sunday",
      },
      month = {
        format = "%Y/%m-%B/%B",
        template = "# %B %Y\n",
        frequency = { month = 1 },
      },
      year = {
        format = "%Y/%Y",
        template = "# %Y\n",
        frequency = { year = 1 },
      },
    },
  },
})

---- blink.cmp -----------------------------------------------------------------
local cmp = require("blink.cmp")
cmp.build():wait(60000)
cmp.setup({
  sources = { default = { "lsp", "path", "snippets", "omni" } },
  keymap = {
    preset = "none",
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
  },
  fuzzy = { implementation = "rust" },
  appearance = { nerd_font_variant = "mono" },
  snippets = { preset = "mini_snippets" },
  completion = {
    list = { selection = { preselect = true, auto_insert = true } },
    trigger = { show_on_insert_on_trigger_character = false },
    accept = { auto_brackets = { enabled = true } },
    documentation = { auto_show = true },
    menu = {
      draw = {
        columns = {
          { "kind_icon", "kind", gap = 1 },
          { "label", "label_description", gap = 1 },
          { "source_name" },
        },
      },
    },
  },
  cmdline = {
    enabled = true,
    completion = { menu = { auto_show = false, draw = { columns = { { "kind_icon", gap = 1 }, { "label" } } } } },
    keymap = {
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<Tab>"] = { "show_and_insert", "insert_next", "fallback" },
      ["<S-Tab>"] = { "show_and_insert", "insert_prev", "fallback" },
      ["<Up>"] = { "select_prev" },
      ["<Down>"] = { "select_next" },
    },
  },
  signature = { enabled = false },
})

---- which-key -----------------------------------------------------------------
require("which-key").setup({
  preset = "helix",
  plugins = { presets = { motions = false, text_objects = false, operators = false, mappings = true } },
  icons = { rules = false, separator = "→" },
  sort = { "local", "order", "group", "manual", "alphanum", "mod" },
})
require("which-key").add({
  { "gS", desc = "mini.splitjoin Toggle" },
  { "gr", group = "LSP" },
  { "gra", desc = "LSP code action" },
  { "gri", desc = "LSP implementations" },
  { "grr", desc = "LSP references" },
  { "grt", desc = "LSP type definitions" },
  { "grn", desc = "LSP rename" },
  { "<leader>o", group = "Notes" },
})

---- todo-comments -------------------------------------------------------------
require("todo-comments").setup({
  keywords = {
    FIX = { icon = "󰅜" },
    HACK = { icon = "" },
    PERF = { icon = "", color = "pass", alt = { "DONE", "CHECKED", "OK", "PASS" } },
    TODO = { icon = "" },
    INFO = { icon = "󰋼" },
  },
  highlight = { keyword = "bg", after = "", pattern = [[.*<(KEYWORDS)\s*]] },
  search = { pattern = [[\b(KEYWORDS)]] },
  colors = { pass = { "DiagnosticOk", "#92a650" } },
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
      {
        "branch",
        color = { fg = "#92a650" },
        icon = { "𖣂", color = { fg = "#92a650" } },
        padding = { left = 0, right = 1 },
      },
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
        ignore_lsp = { "render-markdown", "obsidian-ls", "mini.snippets" },
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
  window = { width = 100, backdrop = 1, options = { signcolumn = "no" } },
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
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = "󱨰 ", key = "t", desc = "Today's journal entry", action = "<cmd>:Journal<CR>" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
        { icon = " ", key = "p",  desc = "Projects",     action  = ":lua Snacks.picker.projects()" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
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
  indent = { indent = { char = "▏" }, animate = { enabled = false }, scope = { enabled = false } },
  picker = {
    sources = {
      recent = { layout = "select" },
      projects = {
        dev = { "~/git", "~/Documents/writing/novels" },
        filter = { paths = { ["~/.local/share/nvim/"] = false } },
        patterns = { ".git", "package.json" },
        layout = "default",
        projects = {
          "~/.config/nvim",
          "~/.config/rmpc",
          "~/.local/bin",
        },
      },
      explorer = { win = { list = { keys = { ["d"] = "explorer_del" } } } },
    },
  },
})
