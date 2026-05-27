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
