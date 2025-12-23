local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- JDTLS se inicia SOLO cuando abrimos un archivo Java
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local root_dir = lspconfig.util.root_pattern(
      "pom.xml",
      "build.gradle",
      ".git"
    )(vim.fn.getcwd())

    if not root_dir then
      return
    end

    local workspace_dir =
      vim.fn.stdpath("data")
      .. "/jdtls-workspace/"
      .. vim.fn.fnamemodify(root_dir, ":p:h:t")

    lspconfig.jdtls.setup({
      cmd = {
        vim.fn.expand(
          "~/.local/share/eclipse/jdt-language-server-1.54.0-202511200503/bin/jdtls"
        ),
        "-data",
        workspace_dir,
      },
      root_dir = root_dir,
      capabilities = capabilities,
    })
  end,
})

-- Keymaps LSP
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
