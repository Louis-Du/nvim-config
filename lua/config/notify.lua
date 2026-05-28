local notify = require("notify")
notify.setup({
  stages = "fade",
  timeout = 3000,
  background_colour = "#000000",
  top_down = true,
  fps = 60,
  minimum_width = 30,
  max_width = 80,
  max_height = 10,
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
  position = "bottom_right",
})

vim.notify = notify