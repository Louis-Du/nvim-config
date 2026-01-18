local ok_lsp, lspconfig = pcall(require, "lspconfig")
if not ok_lsp then return end

local ok_jdtls, jdtls = pcall(require, "jdtls")
if not ok_jdtls then
  vim.notify("nvim-jdtls no está instalado o no carga", vim.log.levels.WARN)
end

local cmp_lsp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_lsp_ok then return end

local capabilities = cmp_lsp.default_capabilities()

-- Intentar encontrar JDTLS en ubicaciones comunes
local function find_jdtls_cmd()
  local possible_paths = {
    vim.fn.expand("~/.local/share/eclipse/jdt-language-server/bin/jdtls"),
    "/usr/local/bin/jdtls",
    "/usr/bin/jdtls",
  }
  
  for _, path in ipairs(possible_paths) do
    if vim.fn.executable(path) == 1 then
      return path
    end
  end
  
  return nil
end

-- JDTLS se inicia SOLO cuando abrimos un archivo Java
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local jdtls_cmd = find_jdtls_cmd()
    if not jdtls_cmd then
      vim.notify("JDTLS no encontrado. Instálalo o configura la ruta en lsp.lua", vim.log.levels.WARN)
      return
    end

    -- Detectar root del proyecto con base en el archivo actual
    local bufname = vim.api.nvim_buf_get_name(0)
    local file_dir = vim.fn.fnamemodify(bufname, ":p:h")
    local root_dir = lspconfig.util.root_pattern("pom.xml", "build.gradle", ".git")(file_dir)

    -- Fallback: si no hay root, usar el directorio del archivo
    if not root_dir or root_dir == "" then
      root_dir = file_dir
      vim.notify("JDTLS: usando directorio del archivo como root (no se encontró pom.xml/gradle/git)", vim.log.levels.INFO)
    end

    local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

    local config = {
      cmd = { jdtls_cmd, "-data", workspace_dir },
      root_dir = root_dir,
      capabilities = capabilities,
    }

    if ok_jdtls then
      jdtls.start_or_attach(config)
    else
      -- Fallback: intentar vía lspconfig (menos fiable)
      lspconfig.jdtls.setup(config)
    end
  end,
})

-- Keymaps LSP
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
