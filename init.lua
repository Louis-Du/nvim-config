
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")


require("plugins")

for _, module in ipairs({
  "config.lsp",
  "config.cmp",
  "config.treesitter",
  "config.nvimtree",
  "config.autopairs",
  "config.comment",
  "config.format",
  "config.telescope",
  "config.luasnip",
  "config.trouble",
  "config.whichkey",
  "config.bufferline",
  "config.theme",
  "config.lualine",
  "config.indent",
  "config.noice",
  "config.smear_cursor",
  "config.toggleterm",
  "config.reader",
  "config.localhighlight",
  "config.animate",
  "config.markdownpreview",
  "config.hop",
  "config.diffview",
  "config.rainbow",
  "config.dap",
  "config.dap-java",
}) do
  pcall(require, module)
end


require("core.diagnostics")
require("core.keymaps")
require("core.dashboard")
