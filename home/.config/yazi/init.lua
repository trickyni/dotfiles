require("starship"):setup({
  config_file = "~/.config/starship/starship_oneline.toml",
})

-- require("no-status"):setup()

-- require("restore"):setup({
--   position = { "center", w = 70, h = 40 },
--   show_confirm = true,
-- })
require("recycle-bin"):setup()
require("relative-motions"):setup({ show_numbers = "relative_absolute" })
