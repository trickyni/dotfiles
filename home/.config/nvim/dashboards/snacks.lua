----snacks-----------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim", { load = false } },
})

require("snacks").setup({
  dashboard = {
    width = 40,
    preset = {
      keys = {
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "\\", desc = "File Explorer", action = ":Yazi" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":Pick oldfiles" },
        {
          icon = " ",
          key = "p",
          desc = "Projects",
          action = ":Pick projects",
        },
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
    formats = {},
    sections = {
      { section = "header", indent = 5 },
      { title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { section = "keys", indent = 2, padding = 1 },
    },
  },
})
