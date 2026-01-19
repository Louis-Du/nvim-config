-- Dashboard minimalista e interactivo
local M = {}

local messages = {
  "Hoy sabes más que cuando empezaste.",
  "El código también es una forma de pensar.",
  "Paso a paso también es progreso.",
  "Si puedes imaginarlo, puedes programarlo.",
  "La constancia vence al talento distraído.",
  "El error es parte del camino, no del final.",
  "Escribe código como quien deja huella.",
  "Lo difícil de hoy será rutina mañana.",
}

math.randomseed(os.time())

local function center_text(lines)
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  local padded = {}
  local top_padding = math.floor((height - #lines) / 2)

  for _ = 1, top_padding do
    table.insert(padded, "")
  end

  for _, line in ipairs(lines) do
    local pad = math.floor((width - #line) / 2)
    table.insert(padded, string.rep(" ", math.max(pad, 0)) .. line)
  end

  return padded
end

function M.setup()
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      -- Solo mostrar si no hay archivos al iniciar
      if vim.fn.argc() > 0 then
        return
      end

      local msg = messages[math.random(#messages)]

      vim.cmd("enew")
      local buf = vim.api.nvim_get_current_buf()

      -- Configurar buffer como dashboard
      vim.bo[buf].buftype = "nofile"
      vim.bo[buf].bufhidden = "wipe"
      vim.bo[buf].swapfile = false
      vim.bo[buf].buflisted = false
      vim.bo[buf].modifiable = true

      -- Contenido del dashboard
      local lines = {
        "",
        msg,
        "",
        "  [n]  Nuevo archivo",
        "  [f]  Buscar archivo",
        "  [r]  Recientes",
        "  [e]  Explorador",
        "  [q]  Salir",
        "",
      }

      lines = center_text(lines)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.bo[buf].modifiable = false

      -- Estilo del dashboard
      vim.cmd([[
        setlocal
          nonumber
          norelativenumber
          nocursorline
          nospell
          signcolumn=no
      ]])

      -- Keymaps interactivos (solo para este buffer)
      local map = function(key, cmd, desc)
        vim.keymap.set("n", key, cmd, { 
          buffer = buf, 
          silent = true,
          desc = desc
        })
      end

      map("n", "<cmd>enew<CR>", "Nuevo archivo")
      map("f", "<cmd>Telescope find_files<CR>", "Buscar archivo")
      map("r", "<cmd>Telescope oldfiles<CR>", "Archivos recientes")
      map("e", "<cmd>NvimTreeToggle<CR>", "Explorador")
      map("q", "<cmd>qa<CR>", "Salir")

      -- Cerrar dashboard al abrir cualquier archivo
      vim.api.nvim_create_autocmd("BufEnter", {
        buffer = buf,
        callback = function()
          local current_buf = vim.api.nvim_get_current_buf()
          if current_buf ~= buf and vim.bo[current_buf].buftype == "" then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end,
      })
    end,
  })
end

M.setup()

return M
