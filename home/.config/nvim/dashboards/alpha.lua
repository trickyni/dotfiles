vim.pack.add({ { src = "https://github.com/goolord/alpha-nvim" } })
local alpha = require("alpha")
local theta = require("alpha.themes.theta")
local dashboard = require("alpha.themes.dashboard")
theta.header.val = {
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
-- theta.buttons.val = {
--   dashboard.button("n", "  New file", ":ene | startinsert <CR>"),
--   dashboard.button("\\", "  File explorer", ":Yazi<CR>"),
--   dashboard.button("r", "  Recent files", ":Pick oldfiles"),
--   dashboard.button("p", "  Projects", ":Pick projects"),
--   dashboard.button("q", "  Quit", ":qa"),
-- }
alpha.setup(theta.config)
