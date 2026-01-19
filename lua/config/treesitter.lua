-- lua/config/treesitter.lua
local ok, configs = pcall(require, "nvim-treesitter.config")
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
