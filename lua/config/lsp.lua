local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

-- Capacidades para cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local root_dir = lspconfig.util.root_pattern(
  ".git",
  "mvnw",
  "gradlew",
  "pom.xml",
  "build.gradle"
)

if root_dir ~= nil then
  lspconfig.jdtls.start_or_attach({
    cmd = {
      vim.fn.expand("~/.local/share/eclipse/jdt-language-server-1.54.0-202511200503/bin/jdtls")
    },
    root_dir = root_dir,
    capabilities = capabilities,
  })
end


-- Keymaps LSP
local opts = { noremap=true, silent=true }
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
