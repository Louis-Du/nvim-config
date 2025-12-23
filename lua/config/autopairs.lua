local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then return end

npairs.setup({
  check_ts = true,
  enable_check_bracket_line = false,
  fast_wrap = {},
})

local cmp_ok, cmp = pcall(require, "cmp")
if cmp_ok then
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
