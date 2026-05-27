local map = vim.keymap.set
map("n", "<leader>r", "<cmd>lua Snacks.picker.recent()<CR>", { desc = "Recent Files" })
map("n", "<leader>p", "<cmd>lua Snacks.picker.projects()<CR>", { desc = "Projects" })
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
          "~/.local/bin",
        },
      },
      explorer = { win = { list = { keys = { ["d"] = "explorer_del" } } } },
    },
  },
})
