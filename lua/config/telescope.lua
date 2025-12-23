local ok, telescope = pcall(require, "telescope")
if not ok then return end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "❯ ",
    sorting_strategy = "ascending",
    layout_config = { prompt_position = "top" },
    mappings = { i = { ["<Esc>"] = actions.close } },
  },
})
