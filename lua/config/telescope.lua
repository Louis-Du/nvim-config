local ok, telescope = pcall(require, "telescope")
if not ok then 
  vim.notify("Telescope not available or requires newer Neovim version", vim.log.levels.WARN)
  return 
end

local actions_ok, actions = pcall(require, "telescope.actions")
if not actions_ok then
  vim.notify("Telescope actions not available", vim.log.levels.WARN)
  return
end

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "❯ ",
    sorting_strategy = "ascending",
    layout_config = { prompt_position = "top" },
    mappings = { i = { ["<Esc>"] = actions.close } },
  },
})
