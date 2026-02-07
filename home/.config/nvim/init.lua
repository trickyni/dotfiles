vim.pack.add({ "https://codeberg.org/trickyni/desert-witch.nvim" })
vim.cmd.colorscheme("desert-witch")
-- OPTION  ----------------------------------------------------
--stylua: ignore start
vim.g.mapleader      = " " -- leader key (spacebar)
vim.g.have_nerd_font = true
vim.opt.shortmess:append("Swl")
vim.opt.number       = true -- number column
vim.opt.ignorecase   = true -- search ignores case
vim.opt.smartcase    = true -- search ignores case unless uppercase letter exists
vim.opt.wrap         = true
vim.opt.textwidth    = 80
vim.opt.linebreak    = true
vim.opt.shiftwidth   = 2 -- indentation width
vim.opt.tabstop      = 2 -- tab width
vim.opt.softtabstop  = 2
vim.opt.expandtab    = true -- turns tabs into spaces
vim.opt.showmode     = false -- hides mode indicator, since we have a status line
vim.opt.cursorline   = true -- highlights cursor line
vim.opt.scrolloff    = 10 -- keeps 10 lines above/below the cursor when scrolling
vim.opt.breakindent  = true
vim.opt.signcolumn   = "yes:1" -- gutter to the left of the number column
vim.opt.inccommand   = "nosplit" -- shows find/replace results live
vim.opt.backspace    = { "start", "eol", "indent" }
vim.opt.list         = true -- show trailing whitespaces and tab characters
vim.opt.listchars    = {tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.timeoutlen   = 300 --timeout on keys with followups
vim.opt.winborder    = "rounded" --border for floating windows
vim.opt.spelllang    = "en_us"
vim.opt.spell        = true
--stylua: ignore end
-- KEYMAPS ----------------------------------------------------
vim.keymap.set("n", "<C-n>", ":enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<C-]>", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-[>", ":bp<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "clear highlights" })
vim.keymap.set("n", "<CR>", "<cmd>ToggleCheckbox<CR>", { desc = "Toggle Checkbox" })
vim.keymap.set("n", "zm", ":ZenMode<CR>", { desc = "Zen mode" })
vim.keymap.set({ "n", "v" }, "<Bslash>", "<cmd>Yazi<CR>", { desc = "yazi" })
vim.keymap.set({ "n", "x" }, "<leader>s", "<Cmd>RipSubstitute<CR>", { desc = " rip substitutdde" })
vim.keymap.set("n", "<leader>d", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>r", ":lua Snacks.picker.recent()<CR>", { desc = "Recent Files" })
vim.keymap.set("n", "<leader>p", ":lua Snacks.picker.projects()<CR>", { desc = "Projects" })
vim.keymap.set("n", "<leader>m", ":lua Snacks.picker.man()<CR>", { desc = "Man-pages" })
vim.keymap.set("n", '<leader>"', ":lua Snacks.picker.registers()<CR>", { desc = "Registers" })
vim.keymap.set("n", "<leader>t", ":lua Snacks.picker.todo_comments()<CR>", { desc = "Todo" })

-- Behaviors --------------------------------------------------
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- sync OS/nvim clipboards
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- Diagnostic configs ----------------------------
vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
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
--
-- Plugins ----------------------------------
vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
  { src = "https://github.com/sitiom/nvim-numbertoggle" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/preservim/vim-pencil" },
  { src = "https://github.com/bullets-vim/bullets.vim" },
  { src = "https://github.com/folke/zen-mode.nvim" },
  { src = "https://github.com/nvim-mini/mini.comment" },
  { src = "https://github.com/nvim-mini/mini.move" },
  { src = "https://github.com/nvim-mini/mini.surround" },
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
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/OXY2DEV/helpview.nvim" },
})
require("mini.comment").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.align").setup()
require("tabout").setup({ tabkey = "<Tab>" })
require("todo-comments").setup({
  highlight = { keyword = "bg", after = "", pattern = [[.*<(KEYWORDS)\s*]] },
  search = { pattern = [[\b(KEYWORDS)]] },
})
require("rip-substitute").setup({ popupWin = { border = "rounded" } })
require("neoscroll").setup({ easing = "quintic" })
require("which-key").setup({ preset = "helix", plugins = { presets = { motions = false } } })
require("gitsigns").setup({ signs = { delete = "─" } })
require("yazi").setup({ yazi_floating_window_border = "rounded" })
require("ibl").setup({ indent = { char = "▏" }, scope = { enabled = false } })
require("trouble").setup({ focus = true, multiline = true, keys = { ["<esc>"] = "close" } })
require("live-command").setup({ commands = { Norm = { cmd = "norm" }, G = { cmd = "g" } } })
vim.cmd("cnoreabbrev norm Norm")
vim.cmd("cnoreabbrev g G")

vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "bashls",
  "qmlls",
  "tombi",
})
---conform.nvim-------------------------------------------------------
require("conform").setup({
  format_on_save = true,
  --stylua: ignore start
  formatters_by_ft = {
    sh         = { "shfmt" },
    lua        = { "stylua" },
    javascript = { "prettier" },
    markdown   = { "prettier" },
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
  --stylua: ignore end
})
----------------------------------------------------------------------
--blink.cmp----------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/MahanRahmati/blink-nerdfont.nvim" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
})
require("blink.cmp").setup({
  keymap = { preset = "super-tab" },
  fuzzy = { implementation = "prefer_rust", prebuilt_binaries = { force_version = "0.6.0" } },
  appearance = { nerd_font_variant = "mono" },
  completion = {
    accept = { auto_brackets = { enabled = true } },
    documentation = { auto_show = true },
  },
  sources = {
    default = { "lsp", "path", "snippets", "nerdfont" },
    providers = {
      nerdfont = {
        module = "blink-nerdfont",
        name = "Nerd Fonts",
        score_offset = 15, -- Tune by preference
        opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
      },
    },
  },
  cmdline = { enabled = true },
  signature = { enabled = false },
})

----treesitter---------------------------------------------------------
require("nvim-treesitter").setup({
  highlight = { enable = true },
  -- stylua: ignore start
  ensure_installed = {
    "bash", "caddy", "comment", "css",    "csv",      "diff",            "dockerfile", "html",  "javascript",
    "jq",   "json",  "jsx",     "lua",    "markdown", "markdown_inline", "qmljs",      "regex", "sql",
    "toml", "typst", "sway",    "vimdoc", "yaml",     "rust",            "ron",
  },
})
-- stylua: ignore end

---RenderMarkdown-----------------------------------------------------
require("render-markdown").setup({
  render_modes = true,
  completions = { lsp = { enabled = true } },
  checkbox = {
    checked = { icon = "󰫈", scope_highlight = "RenderMarkdownCheckedItem" },
    unchecked = { icon = "󰋙", scope_highlight = nil },
    custom = {
      sixth = { raw = "[a]", rendered = "󰫃 ", highlight = "RenderMarkdownBullet" },
      third = { raw = "[b]", rendered = "󰫄 ", highlight = "RenderMarkdownBullet" },
      half = { raw = "[o]", rendered = "󰫅 ", highlight = "RenderMarkdownBullet" },
      twothirds = { raw = "[d]", rendered = "󰫆 ", highlight = "RenderMarkdownBullet" },
      fivesix = { raw = "[e]", rendered = "󰫇 ", highlight = "RenderMarkdownBullet" },
      todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
    },
  },
  wiki = { scope_highlight = "RenderMarkdownWikiLinkText" },
  bullet = { icons = { "󰆧" } },
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
})
---
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    vim.treesitter.start(args.buf, "markdown")
    vim.bo.shiftwidth = 2
  end,
})
----bullets-vim--------------------------------------------------------
vim.g.bullets_checkbox_markers = " abodeX"

----mini.move---------------------------------------------------------
require("mini.move").setup({
  mappings = {
    left = "<S-left>",
    right = "<S-right>",
    down = "<S-down>",
    up = "<S-up>",
    line_left = "<S-left>",
    line_right = "<S-right>",
    line_down = "<S-down>",
    line_up = "<S-up>",
  },
})

----mini.tabline------------------------------------------------------
require("mini.tabline").setup({
  format = function(buf_id, label)
    local suffix = vim.bo[buf_id].modified and "+ " or ""
    return MiniTabline.default_format(buf_id, label) .. suffix
  end,
})

----lualine-----------------------------------------------------------
require("lualine").setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "🭑", right = "🭔" },
  },
  sections = {
    lualine_b = {
      { "branch", icon = { "𖣂", color = { fg = "#92a650" } } },
      { "diff", padding = { left = 0, right = 1 } },
    },
    lualine_c = {
      { "filename", symbols = { modified = "", readonly = { "", color = { fg = "#e86045" } } } },
      { "diagnostics", padding = 0 },
    },
    lualine_x = {
      { "lsp_status", color = "OkMsg", padding = 0, icon = "", symbols = { done = "" }, show_name = false },
      { "filetype", colored = false },
    },
    lualine_y = { "progress" },
    lualine_z = { "searchcount", "location" },
  },
})

----rainbow-delimeters----------------------------------------------------
vim.g.rainbow_delimiters = {
  highlight = { "RainbowDelimiterRed", "RainbowDelimiterYellow", "RainbowDelimiterBlue", "RainbowDelimiterOrange" },
  blacklist = { "html" },
}

----snacks-----------------------------------------------------------------
vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("snacks").setup({
  dashboard = {
    width = 40,
    preset = {
      keys = {
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "\\", desc = "File Explorer", action = ":Yazi" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
        { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
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
    -- formats = {},
    sections = {
      { section = "header", indent = 5 },
      { title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { section = "keys", indent = 2, padding = 1 },
    },
  },
  picker = {
    layout = "select",
    sources = {
      registers = {
        layout = { preview = false, preset = "right" },
        preview = false,
      },
      confirm = { "paste", "close" },
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
    },
  },
})
