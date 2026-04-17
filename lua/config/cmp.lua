local lspkind_ok, lspkind = pcall(require, "lspkind")
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then return end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then return end

local formatting = {}
if lspkind_ok then
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '…',
    })
  }
end

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noselect',
  },
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
    { name = "nvim_lsp" },   -- 🔥 funciones, métodos, ()
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },

  formatting = formatting,
})

-- Autocompletado para :
cmp.setup.cmdline(':', {
  mapping = {
    ['<CR>'] = {
      c = function(fallback)
        fallback() -- ejecuta el comando escrito
      end,
    },

    ['<Up>'] = {
      c = function()
        if cmp.visible() then
          cmp.select_prev_item()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Up>', true, false, true), 'n', true)
        end
      end,
    },

    ['<Down>'] = {
      c = function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Down>', true, false, true), 'n', true)
        end
      end,
    },

    ['<Tab>'] = {
      c = function()
        cmp.select_next_item()
      end,
    },

    ['<S-Tab>'] = {
      c = function()
        cmp.select_prev_item()
      end,
    },
  },

  sources = {
    { name = 'cmdline' }
  },

  formatting = formatting,
})
