-- stylua: ignore start
-- NORMAL mode Enter key
local n_cr_steps = {}
n_cr_steps[1] = {
  condition = function() return require("obsidian.api").cursor_link() end,
  action = function() return "<cmd>Obsidian follow_link<CR>" end,
}
n_cr_steps[2] = {
  condition = function() return require("obsidian.api").cursor_tag() end,
  action = function() return "<cmd>Obsidian tags<CR>" end,
}
n_cr_steps[3] = {
  condition = function() return require("obsidian.api").cursor_heading() end,
  action = function() return "zaj" end,
}
n_cr_steps[4] = {
  condition = function() return vim.bo.filetype == "markdown" end,
  action = function() return "<cmd>ToggleCheckbox<CR>j" end,
}
-- NORMAL mode Shift-Enter key
local n_s_cr_steps = {}
n_s_cr_steps[1] = {
  condition = function() return require("obsidian.api").cursor_heading() end,
  action = function() return "zak" end,
}
n_s_cr_steps[2] = {
  condition = function() return vim.bo.filetype == "markdown" end,
  action = function() return "<cmd>ToggleCheckbox<CR>k" end,
}

-- INSERT mode enter key
local i_cr_steps = {"blink_accept",nil,"minipairs_cr"}
i_cr_steps[2] = {
  condition = function() return vim.bo.filetype == "markdown" end,
  action = function() return "<cmd>InsertNewBullet<CR>" end,
}

local multistep = require("mini.keymap").map_multistep
multistep("i", "<Tab>", { "minisnippets_next", "minisnippets_expand", "blink_next", "jump_after_close" })
multistep("i", "<S-Tab>", { "minisnippets_prev", "blink_prev", "jump_before_open" })
multistep("i", "<BS>", { "minipairs_bs" })
multistep("i", "<CR>", i_cr_steps)
multistep("n", "<CR>", n_cr_steps)
multistep("n", "<S-CR>", n_s_cr_steps)
--stylua: ignore end
-- double-tap pair for a single instance
local combo = require("mini.keymap").map_combo
combo("i", "((", "<BS><BS>(", { delay = 300 })
combo("i", "[[", "<BS><BS>[", { delay = 300 })
combo("i", "{{", "<BS><BS>{", { delay = 300 })
combo("i", '""', '<BS><BS>"', { delay = 300 })
combo("i", "``", "<BS><BS>`", { delay = 300 })
