vim.pack.add({ { src = "https://github.com/nvimdev/dashboard-nvim" } })

local logo = {
  [[                                  ]],
  [[   ,-.       _,---._ __  / \      ]],
  [[  /  )    .-'       `./ /   \     ]],
  [[ (  (   ,'            `/    /|    ]],
  [[  \  `-"             \'\   / |    ]],
  [[    /`.          ,'-`----Y   |    ]],
  [[    `.              ,  \ \ /  |   ]],
  [[   (            ;        |   '    ]],
  [[   |  ,-.    ,-'         |  /     ]],
  [[   |  | (   |            | /      ]],
  [[   )  |  \  `.___________|/       ]],
  [[   `--'   `--'                    ]],
}
require("dashboard").setup({
  disable_move = true,
  shortcut_type = "number",
  hide = { statusline = false },
  config = {
    shortcut = {},
    packages = { enable = false },
    project = { enable = false },
    mru = { limit = 5, icon = "", label = "" },
    footer = {},
  },
})

-- vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "", bg = "" })
-- vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "", bg = "" })
-- vim.api.nvim_set_hl(0, "DashboardMruTitle", { fg = "", bg = "" })
-- vim.api.nvim_set_hl(0, "DashboardMruIcon", { fg = "", bg = "" })
vim.api.nvim_set_hl(0, "DashboardFiles", { fg = "#c1a387", bg = "" })
-- vim.api.nvim_set_hl(0, "DashboardShortCutIcon", { fg = "", bg = "" })
