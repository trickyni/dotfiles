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

