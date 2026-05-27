local map = vim.keymap.set
map("n", "<leader>ot", "<cmd>Journal <CR>", { desc = "Today's daily note" })
map("n", "<leader>on", "<cmd>Journal +1<CR>", { desc = "Tomorrow's daily note" })
map("n", "<leader>oy", "<cmd>Journal -1<CR>", { desc = "Yesterday's daily note" })

local weekday_format = "%Y/%m-%B/daily/%Y-%m-%d__%A"
local weekday_template =
  "---\nid: %Y-%m-%d__%A\naliases: []\ntags:\n - daily-notes\n---\n\n# %Y-%m-%d__%A\n\n## Achievements\n\n## Reflect\n\n## Do\n\n## Observations\n\n## Gratitude\n"
require("journal").setup({
  filetype = "md",
  root = "~/Documents/journal",
  date_format = "%Y-%m-%d",
  autocomplete_date_modifier = "end",
  journal = { --Default journal format (same as day)
    format = weekday_format,
    template = weekday_template,
    frequency = { day = 1 },
    entries = {
      sun = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "last sunday",
      },
      mon = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "monday",
      },
      tue = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "tuesday",
      },
      wed = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "wednesday",
      },
      thu = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "thursday",
      },
      fri = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "friday",
      },
      sat = {
        format = weekday_format,
        template = weekday_template,
        frequency = { day = 7 },
        date_modifier = "saturday",
      },
      week = {
        format = function(date)
          local this_week = date:relative({ day = 7 })
          local week_nr = os.date("%U", os.time(this_week.date))
          return "%Y/%m-%B/weekly/%Y-w" .. week_nr
        end,
        template = function(date)
          local this_sat = date:relative({ day = 6 })
          local week_end = os.date("%b %-d", os.time(this_sat.date))
          local week_nr = tonumber(os.date("%U", os.time(this_sat.date)) + 1)
          return "# Week " .. week_nr .. " - %b %-d -> " .. week_end .. "\n"
        end,
        frequency = { day = 7 },
        date_modifier = "last sunday",
      },
      month = {
        format = "%Y/%m-%B/%B",
        template = "# %B %Y\n",
        frequency = { month = 1 },
      },
      year = {
        format = "%Y/%Y",
        template = "# %Y\n",
        frequency = { year = 1 },
      },
    },
  },
})
