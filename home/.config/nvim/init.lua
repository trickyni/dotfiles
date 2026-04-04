---- COLORSCHEME ---------------------------------------------------------------
vim.pack.add({ "https://codeberg.org/trickyni/desert-witch.nvim" })
vim.cmd.colorscheme("desert-witch")
---- OPTIONS -------------------------------------------------------------------
--stylua: ignore start
vim.opt.termguicolors  = true
vim.g.mapleader        = " "  -- leader key (spacebar)
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
-- bottom of the file and center screen
map("n", "G", "Gzz", { remap = false, silent = true })
-- Other
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "clear highlights" })
map("n", "ycc", "yygccp", { remap = true, desc = "Duplicate line and comment original" })
map("n", "<C-/>", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show floating diagnostic" })
map("n", "<leader><leader>", "<cmd>ZenMode<CR>", { desc = "Zen mode" })
map({ "n", "v" }, "<Bslash>", "<cmd>Yazi<CR>", { desc = "yazi" })
map({ "n", "v" }, "<C-Bslash>", "<cmd>lua Snacks.picker.explorer()<CR>", { desc = "yazi" })
map({ "n", "x" }, "<leader>s", "<Cmd>RipSubstitute<CR>", { desc = "Find/Replace" })
map("n", "<leader>d", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
map("n", "<leader>r", "<cmd>lua Snacks.picker.recent()<CR>", { desc = "Recent Files" })
map("n", "<leader>p", "<cmd>lua Snacks.picker.projects()<CR>", { desc = "Projects" })
map("n", "<leader>m", "<cmd>lua Snacks.picker.man()<CR>", { desc = "Man-pages" })
map("n", "<leader>t", "<cmd>lua Snacks.picker.todo_comments()<CR>", { desc = "Todo comments" })
map("n", "<leader>z", "<cmd>lua Snacks.picker.zoxide()<CR>", { desc = "Zoxide" })
map({ "n", "v" }, '<leader>"', "<cmd>lua Snacks.picker.registers()<CR>", { desc = "Registers" })
map("n", "<leader>g", "<cmd>Gitsigns toggle_linehl<CR>", { desc = "Toggle Diff" })
map("n", "grf", "<cmd>lua require('conform').format()<CR>", { desc = "Format buffer" })
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "LSP go to definition" })

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
  { src = "https://github.com/saghen/blink.cmp" }, --CHECKED: no LLMs
  { src = "https://github.com/MahanRahmati/blink-nerdfont.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/moyiz/blink-emoji.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/Saghen/blink.compat" }, --CHECKED: no LLMs
  { src = "https://github.com/dimtion/guttermarks.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/cosmicbuffalo/eyeliner.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/abecodes/tabout.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/tpope/vim-abolish" }, --CHECKED: no LLMs
  { src = "https://github.com/alex-popov-tech/store.nvim" }, --CHECKED: no LLMs
  { src = "https://github.com/obsidian-nvim/obsidian.nvim" }, --CHECKED: no LLMs
})

-- vim.g.wiki_root = "~/Sync/"
require("mini.pairs").setup()
require("mini.comment").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.align").setup()
require("eyeliner").setup({ dim = true, disabled_buftypes = { "nofile" } })
require("rip-substitute").setup({ popupWin = { border = "rounded" } })
require("gitsigns").setup({ signs = { delete = "─" } })
require("yazi").setup({ yazi_floating_window_border = "rounded", open_for_directories = true })
require("trouble").setup({ focus = true, multiline = true, keys = { ["<esc>"] = "close" } })
require("tabout").setup({ completion = true, act_as_tab = true })
require("colorizer").setup({ options = { parsers = { names = { enable = false } } } })
require("neoscroll").setup({ easing = "sine", use_local_scrolloff = true })
map("n", "<PageUp>", "<cmd>lua require('neoscroll').ctrl_u({duration=300})<CR>", { remap = true })
map("n", "<PageDown>", "<cmd>lua require('neoscroll').ctrl_d({duration=300})<CR>", { remap = true })
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
      prepend_args = { "--tab-width", "2", "--experimental-ternaries", "true" },
    },
  },
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

---- treesitter ----------------------------------------------------------------
require("nvim-treesitter").setup({
  highlight = { enable = true },
})
require("nvim-treesitter").install({
  "caddy",
  "css",
  "csv",
  "desktop",
  "diff",
  "dockerfile",
  "editorconfig",
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "html",
  "jq",
  "kitty",
  "regex",
  "robots_txt",
  "sql",
  "tmux",
  "typst",
  "sway",
  "vimdoc",
  "xml",
  "yaml",
})

---- obsidian.nvim -------------------------------------------------------------
-- keymaps
map("n", "<leader>od", "<cmd>Obsidian dailies<CR>", { desc = "Daily notes picker" })
map("n", "<leader>ot", "<cmd>Obsidian today<CR>", { desc = "Today's daily note" })
map("n", "<leader>on", "<cmd>Obsidian tomorrow<CR>", { desc = "Tomorrow's daily note" })
map("n", "<leader>oy", "<cmd>Obsidian yesterday<CR>", { desc = "Yesterday's daily note" })
map("n", "<leader>op", "<cmd><CR>", { desc = "Pick from vault" })
map("n", "<leader>ov", "<cmd><CR>", { desc = "Switch vault" })
-- Config
require("obsidian").setup({
  ui = { enable = false },
  legacy_commands = false,
  checkbox = { enabled = false },
  footer = { format = "{{words}} words  {{backlinks}} backlinks" },
  templates = {
    folder = ".tmp",
    customizations = {
      weekly = {
        notes_subdir = "journal/weekly/",
        date_format = "YYYY/MMMM/YYYY-wWW",
      },
    },
  },
  note_id_func = require("obsidian.builtin").title_id,
  workspaces = {
    {
      name = "Sync",
      path = "~/Sync",
    },
  },
  daily_notes = {
    enabled = true,
    folder = "journal/",
    template = "~/Sync/.tmp/daily",
    default_tags = { "daily-notes" },
    workdays_only = false,
    date_format = "YYYY/MMMM/YYYY-MM-DD__dddd",
  },
  callbacks = {
    enter_note = function(note)
      vim.keymap.del("n", "<CR>", { buffer = true })
      vim.keymap.set("n", "<CR>", "<cmd>ToggleCheckbox<CR>j", { remap = false, buffer = true })
    end,
  },
})

---- blink.cmp -----------------------------------------------------------------
require("blink.cmp").setup({
  keymap = {
    preset = "enter",
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
  },
  fuzzy = { implementation = "lua" },
  appearance = { nerd_font_variant = "mono" },
  completion = {
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
  sources = {
    default = { "lsp", "path", "snippets", "omni", "nerdfont", "emoji" },
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
  cmdline = {
    enabled = true,
    -- keymap = { ["<CR>"] = { "accept", "fallback" } },
    keymap = {
      ["<Tab>"] = { "show", "accept", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
    },
    completion = {
      menu = {
        auto_show = false,
        draw = {
          columns = {
            { "kind_icon", gap = 1 },
            { "label" },
          },
        },
      },
      ghost_text = { enabled = true },
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
  { "cr", group = "Change case" },
  { "crc", desc = "camelCase" },
  { "cr_", desc = "snake_case" },
  { "crs", desc = "snake_case" },
  { "cru", desc = "SNAKE_UPPERCASE" },
  { "gr", group = "LSP" },
  { "gra", desc = "LSP code action" },
  { "gri", desc = "LSP implementations" },
  { "grr", desc = "LSP references" },
  { "grt", desc = "LSP type definitions" },
  { "grn", desc = "LSP rename" },
  { "<leader>o", group = "Obsidian" },
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
        ignore_lsp = { "render-markdown", "obsidian-ls" },
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
        { icon = "󱨰 ", key = "t", desc = "Today's journal entry", action = "<cmd>Obsidian today<CR>" },
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
  indent = {
    indent = { char = "▏" },
    animate = { enabled = false },
    scope = { enabled = false },
  },
  picker = {
    sources = {
      man = { layout = "select" },
      recent = { layout = "select" },
      zoxide = { layout = "select" },
      registers = {
        layout = { preview = false, preset = "right" },
        preview = false,
        confirm = { "paste", "close" },
      },
      projects = {
        dev = { "~/git", "~/Documents/writing/novels" },
        filter = { paths = { ["~/.local/share/nvim/"] = false } },
        patterns = { ".git" },
        layout = "default",
        projects = {
          "~/.config/nvim",
          "~/.config/rmpc",
          "~/.config/sway",
          "~/.config/niri",
        },
      },
      todo_comments = { buffers = true, layout = "select" },
      explorer = { win = { list = { keys = { ["d"] = "explorer_del" } } } },
    },
  },
})
