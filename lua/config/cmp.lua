local ok, cmp = pcall(require, "cmp")
if not ok then return end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then return end

require("luasnip.loaders.from_lua").lazy_load({
  paths = "~/.config/nvim/lua/snippets"
})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
})
