--- Mini.Starter----------------------------------------------------------
vim.pack.add({ { src = "https://github.com/nvim-mini/mini.starter" } })

local logo = [[
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
]]

local starter = require("mini.starter")
starter.setup({
  evaluate_single = true,
  header = logo,
  footer = " ",
  items = {
    starter.sections.recent_files(5, false, false),
    { name = "n    New file", action = ":ene | startinsert", section = " " },
    { name = "\\    File explorer", action = ":Yazi", section = " " },
    { name = "r    Recent files", action = ":Pick oldfiles", section = " " },
    { name = "p    Projects", action = ":Pick projects", section = " " },
    { name = "q    Quit", action = ":qa", section = " " },
  },
  content_hooks = {
    starter.gen_hook.adding_bullet("  ", false),
    starter.gen_hook.aligning("center", "center"),
    starter.gen_hook.indexing("all", { " " }),
  },
})
-- vim.api.nvim_set_hl(0, 'MiniStarterCurrent', { fg = "", bg = "" })
-- vim.api.nvim_set_hl(0, 'MiniStarterFooter', { fg = "", bg = "" })
vim.api.nvim_set_hl(0, "MiniStarterHeader", { fg = "#c1a387", bg = "" })
-- vim.api.nvim_set_hl(0, 'MiniStarterInactive', { fg = "", bg = "" })
-- vim.api.nvim_set_hl(0, 'MiniStarterItem', { fg = "", bg = "" })
vim.api.nvim_set_hl(0, "MiniStarterItemBullet", { fg = "#92a650" })
vim.api.nvim_set_hl(0, "MiniStarterItemPrefix", { fg = "#92a650" })
vim.api.nvim_set_hl(0, "MiniStarterSection", { fg = "#e68d53" })
-- vim.api.nvim_set_hl(0, 'MiniStarterQuery', { fg = "", bg = "" })
------------------------------------------------
