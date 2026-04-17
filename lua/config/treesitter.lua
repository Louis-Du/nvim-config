-- lua/config/treesitter.lua
local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  vim.notify("treesitter configs not found", vim.log.levels.ERROR)
  return
end

configs.setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "java", "python", "javascript", "typescript" },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
  auto_install = false,
})

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "java", "lua", "bash", "json", "yaml", "markdown"
  },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
    },
  },
})
