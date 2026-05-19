require("nvim-treesitter").install({ "nix" })
vim.treesitter.start()
require("conform").formatters_by_ft.nix = { "nixfmt" }
