-- ftplugin/java.lua
-- Configuración de nvim-jdtls para Java

local status_ok, jdtls = pcall(require, 'jdtls')
if not status_ok then
  return
end

local home = os.getenv('HOME')
local jdtls_path = home .. '/.local/share/eclipse'
local workspace_path = home .. '/.local/share/nvim/jdtls-workspace'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. '/' .. project_name

local config = {
  cmd = {
    home .. '/.local/bin/jdtls',
    '-data', workspace_dir,
  },

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),

  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
    }
  },

  init_options = {
    bundles = {}
  },

  on_attach = function(client, bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>dn', "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
    vim.keymap.set('n', '<leader>dt', "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
  end,
}

jdtls.start_or_attach(config)
