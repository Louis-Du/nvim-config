local function strlen(s)
  return vim.fn.strdisplaywidth(s)
end
local function get_git_commits()
  -- Verifica si es repositorio git
  if vim.fn.isdirectory(".git") == 0 then
    return {}
  end

  local handle = io.popen("git log --oneline -n 5 2>/dev/null")
  if not handle then return {} end

  local result = handle:read("*a")
  handle:close()

  local lines = {}
  for line in result:gmatch("[^\r\n]+") do
    table.insert(lines, "  " .. line)
  end

  return lines
end

-- Dashboard minimalista e interactivo
local M = {}

local messages = {
  "𝙷𝚘𝚢 𝚜𝚊𝚋𝚎𝚜 𝚖á𝚜 𝚚𝚞𝚎 𝚌𝚞𝚊𝚗𝚍𝚘 𝚎𝚖𝚙𝚎𝚣𝚊𝚜𝚝𝚎.",
  "𝙴𝚕 𝚌ó𝚍𝚒𝚐𝚘 𝚝𝚊𝚖𝚋𝚒é𝚗 𝚎𝚜 𝚞𝚗𝚊 𝚏𝚘𝚛𝚖𝚊 𝚍𝚎 𝚙𝚎𝚗𝚜𝚊𝚛.",
  "𝙿𝚊𝚜𝚘 𝚊 𝚙𝚊𝚜𝚘 𝚝𝚊𝚖𝚋𝚒é𝚗 𝚎𝚜 𝚙𝚛𝚘𝚐𝚛𝚎𝚜𝚘.",
  "𝚂𝚒 𝚙𝚞𝚎𝚍𝚎𝚜 𝚒𝚖𝚊𝚐𝚒𝚗𝚊𝚛𝚕𝚘, 𝚙𝚞𝚎𝚍𝚎𝚜 𝚙𝚛𝚘𝚐𝚛𝚊𝚖𝚊𝚛𝚕𝚘.",
  "𝙻𝚊 𝚌𝚘𝚗𝚜𝚝𝚊𝚗𝚌𝚒𝚊 𝚟𝚎𝚗𝚌𝚎 𝚊𝚕 𝚝𝚊𝚕𝚎𝚗𝚝𝚘 𝚍𝚒𝚜𝚝𝚛á𝚒𝚍𝚘.",
  "𝙴𝚕 𝚎𝚛𝚛𝚘𝚛 𝚎𝚜 𝚙𝚊𝚛𝚝𝚎 𝚍𝚎𝚕 𝚌𝚊𝚖𝚒𝚗𝚘, 𝚗𝚘 𝚍𝚎𝚕 𝚏𝚒𝚗𝚊𝚕.",
  "𝙴𝚜𝚌𝚛𝚒𝚋𝚎 𝚌ó𝚍𝚒𝚐𝚘 𝚌𝚘𝚖𝚘 𝚚𝚞𝚒𝚎𝚗 𝚍𝚎𝚓𝚊 𝚑𝚞𝚎𝚕𝚕𝚊.",
  "𝙻𝚘 𝚍𝚒𝚏í𝚌𝚒𝚕 𝚍𝚎 𝚑𝚘𝚢 𝚜𝚎𝚛á 𝚛𝚞𝚝𝚒𝚗𝚊 𝚖𝚊ñ𝚊𝚗𝚊.",
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
      print("DASHBOARD AUTOCMD")
      -- Mostrar dashboard solo si no hay archivos abiertos
      if vim.fn.argc() > 0 then
        return
      end

      local buf = vim.api.nvim_get_current_buf()
      local msg = messages[math.random(#messages)]

      -- Limpiar el buffer actual y configurarlo como dashboard
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
      vim.bo[buf].buftype = "nofile"
      vim.bo[buf].bufhidden = "wipe"
      vim.bo[buf].swapfile = false
      vim.bo[buf].buflisted = false
      vim.bo[buf].modifiable = true

      -- ASCII Art
      local ascii_art = {
        "                                       ",
        "                                       ",
        "                                       ",
        "                                       ",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⣀⡴⢧⣀⠀⠀⣀⣠⠤⠤⠤⠤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠘⠏⢀⡴⠊⠁⠀⠀⠀⠀⠀⠀⠈⠙⠦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⣰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢶⣶⣒⣶⠦⣤⣀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⢀⣰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣟⠲⡌⠙⢦⠈⢧⠀",
        "⠀⠀⠀⣠⢴⡾⢟⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡴⢃⡠⠋⣠⠋⠀",
        "⠐⠀⠞⣱⠋⢰⠁⢿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⠤⢖⣋⡥⢖⣫⠔⠋⠀⠀⠀",
        "⠈⠠⡀⠹⢤⣈⣙⠚⠶⠤⠤⠤⠴⠶⣒⣒⣚⣩⠭⢵⣒⣻⠭⢖⠏⠁⢀⣀⠀⠀⠀⠀",
        "⠠⠀⠈⠓⠒⠦⠭⠭⠭⣭⠭⠭⠭⠭⠿⠓⠒⠛⠉⠉⠀⠀⣠⠏⠀⠀⠘⠞⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⢤⣀⠀⠀⠀⠀⠀⠀⣀⡤⠞⠁⠀⣰⣆⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠘⠿⠀⠀⠀⠀⠀⠈⠉⠙⠒⠒⠛⠉⠁⠀⠀⠀⠉⢳⡞⠉⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      }

      -- Contenido del dashboard
      local lines = {}

      -- Columna izquierda: bloque de commits (diseño limpio)
      local commits = get_git_commits()
      local left = {}
      table.insert(left, " ╭─────────────────────  Últimos commits ─────────────────────╮ ")
      if #commits > 0 then
        for _, c in ipairs(commits) do
          local hash, msg = c:match("%s*([a-f0-9]+)%s+(.*)")
          if hash and msg then
            msg = msg:gsub("%s+$", "")
            if strlen(msg) > 50 then
              msg = msg:sub(1, 47) .. "..."
            end
            table.insert(left, string.format("    %-8s %s", hash, msg))
          else
            table.insert(left, "    " .. c)
          end
        end
      else
        table.insert(left, "    No hay commits recientes.")
      end
      table.insert(left, " ╰─────────────────────────────────────────────────────────────╯ ")


      -- Bloque central: mensaje, arte y opciones, todos alineados juntos
      local center_block = {}
      table.insert(center_block, "")
      table.insert(center_block, msg)
      table.insert(center_block, "")
      for _, line in ipairs(ascii_art) do
        table.insert(center_block, line)
      end
      local opts = {
        "",
        "[n]  Nuevo archivo",
        "[f]  Buscar archivo",
        "[r]  Recientes",
        "[e]  Explorador",
        "[q]  Salir",
        ""
      }
      for _, line in ipairs(opts) do
        table.insert(center_block, line)
      end

      -- Centrar el bloque central completo respecto a la zona derecha de la pantalla
      local width = vim.api.nvim_get_option("columns")

      -- ancho del bloque izquierdo (unicode-aware)
      local left_width = 0
      for _, line in ipairs(left) do
        left_width = math.max(left_width, strlen(line))
      end

      local gap = 0 -- espacio fijo entre columnas

      -- ancho del bloque central (unicode-aware)
      local center_width = 0
      for _, line in ipairs(center_block) do
        center_width = math.max(center_width, strlen(line))
      end

      -- espacio disponible a la derecha
      local available = width - left_width - gap

      -- centrar dentro de ese espacio
      local padding = math.max(0, math.floor((available - center_width) / 2))

      for i, line in ipairs(center_block) do
        if i == 2 then -- Solo la frase
          local frase_padding = math.max(0, left_width + gap + padding - 70)
          center_block[i] = string.rep(" ", frase_padding) .. line
        else
          center_block[i] = string.rep(" ", left_width + gap + padding) .. line
        end
      end

      -- Unir ambas columnas, alineando arriba
      local total_lines = math.max(#left, #center_block)
      local lines = {}
      for i = 1, total_lines do
        local l = left[i] or ""
        local c = center_block[i] or ""
        table.insert(lines, l .. c)
      end

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.bo[buf].modifiable = false

      -- Estilo del dashboard (usar API en lugar de setlocal multilinea)
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.cursorline = false
      vim.opt_local.spell = false
      vim.opt_local.signcolumn = "no"

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

      -- Cerrar dashboard al abrir cualquier buffer normal
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function(args)
          -- Si entramos a un buffer normal (no especial), eliminar el dashboard si sigue vivo
          local entered_buf = args.buf
          if vim.bo[entered_buf].buftype == "" and vim.api.nvim_buf_is_valid(buf) then
            -- Borrar el buffer del dashboard
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end,
      })
    end,
  })
end

M.setup()

return M
