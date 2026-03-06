-- Using xan for formatting
---- Options -------------------------------------------------------------------
vim.opt.wrap = false
vim.opt_local.textwidth = 0

---- Keymaps -------------------------------------------------------------------
vim.keymap.set(
  "n",
  "grf",
  ":%!xan fixlengths |xan input --trim |xan dedup<CR>",
  { remap = true, buffer = true, silent = true }
)
vim.keymap.set("n", "<leader>c", "<cmd>CsvViewToggle<CR>", { remap = false, buffer = true, silent = true })

---Treesitter -------------------------------------------------------------------
require("nvim-treesitter").install({ "csv" })
vim.treesitter.start()
---- plugins --------------------------------------------------------------------
require("conform").formatters_by_ft.csv = { "xan" }

vim.pack.add({ "https://github.com/hat0uma/csvview.nvim" }) --CHECKED: no LLMs
require("csvview").setup({
  view = { display_mode = "border", min_column_width = 0, spacing = 0 },
  keymaps = {
    textobject_field_inner = { "if", mode = { "o", "x" } },
    textobject_field_outer = { "af", mode = { "o", "x" } },
    jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
    jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
    jump_next_row = { "<Enter>", mode = { "n", "v" } },
    jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
  },
  -- actions = {},
})
