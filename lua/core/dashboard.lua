-- Calcula el ancho de una cadena considerando caracteres Unicode
local function strlen(s)
  return vim.fn.strdisplaywidth(s)
end

-- Obtiene los últimos commits de git (si es un repo)
local function get_git_commits()
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

-- Obtiene estadísticas del repo git
local function get_git_stats()
  if vim.fn.isdirectory(".git") == 0 then
    return {
      commits = "-",
      branches = "-",
      last = { author = "-", date = "-" }
    }
  end
  local commits = io.popen("git rev-list --count HEAD 2>/dev/null"):read("*l") or "-"
  local branches = io.popen("git branch --list 2>/dev/null | wc -l"):read("*l") or "-"
  local last_author = io.popen("git log -1 --pretty=format:'%an' 2>/dev/null"):read("*l") or "-"
  local last_date = io.popen("git log -1 --date=short --pretty=format:'%ad' 2>/dev/null"):read("*l") or "-"
  return {
    commits = commits,
    branches = branches,
    last = { author = last_author, date = last_date }
  }
end

-- Mensajes motivacionales para el dashboard
local messages = {
  "𝙷𝚘𝚢 𝚜𝚊𝚋𝚎𝚜 𝚖á𝚜 𝚚𝚞𝚎 𝚌𝚞𝚊𝚗𝚍𝚘 𝚎𝚖𝚙𝚎𝚣𝚊𝚜𝚝𝚎.",
  "𝙴𝚕 𝚌ó𝚍𝚒𝚐𝚘 𝚝𝚊𝚖𝚋𝚒é𝚗 𝚎𝚜 𝚞𝚗𝚊 𝚏𝚘𝚛𝚖𝚊 𝚍𝚎 𝚙𝚎𝚗𝚜𝚊𝚛.",
  "𝙿𝚊𝚜𝚘 𝚊 𝚙𝚊𝚜𝚘 𝚝𝚊𝚖𝚋𝚒é𝚗 𝚎𝚜 𝚙𝚛𝚘𝚐𝚛𝚎𝚜𝚘.",
  "𝚂𝚒 𝚙𝚞𝚎𝚍𝚎𝚜 𝚒𝚖𝚊𝚐𝚒𝚗𝚊𝚛𝚕𝚘, 𝚙𝚞𝚎𝚍𝚎𝚜 𝚙𝚛𝚘𝚐𝚛𝚊𝚖𝚊𝚛𝚕𝚘.",
  "𝙻𝚊 𝚌𝚘𝚗𝚜𝚝𝚊𝚗𝚌𝚒𝚊 𝚟𝚎𝚗𝚌𝚎 𝚊𝚕 𝚝𝚊𝚕𝚎𝚗𝚝𝚘 𝚍𝚒𝚜𝚝𝚛á𝚒𝚍𝚘.",
  "𝙴𝚕 𝚎𝚛𝚛𝚘𝚛 𝚎𝚜 𝚙𝚊𝚛𝚝𝚎 𝚍𝚎𝚕 𝚌𝚊𝚖𝚒𝚗𝚘, 𝚗𝚘 𝚍𝚎𝚕 𝚏𝚒𝚗𝚊𝚕.",
  "𝙻𝚘 𝚍𝚒𝚏í𝚌𝚒𝚕 𝚍𝚎 𝚑𝚘𝚢 𝚜𝚎𝚛á 𝚛𝚞𝚝𝚒𝚗𝚊 𝚖𝚊ñ𝚊𝚗𝚊.",
}

math.randomseed(os.time())

-- Módulo principal del dashboard
local M = {}

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

      -- Definir highlights personalizados
      vim.api.nvim_set_hl(0, "DashboardFrase", { fg = "#ffb86c", bold = true })
      vim.api.nvim_set_hl(0, "DashboardMenu", { fg = "#8be9fd", bold = true })

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
      local stats = get_git_stats()
      local left = {}
      table.insert(left, " ╭────────────────────  Últimos commits ─────────────────────╮ ")
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
      -- Bloque de estadísticas de GitHub
      -- Compactar bloque de estadísticas para no desformar el ASCII
      table.insert(left, string.format("   Repo:  %s   %s   %s   %s", stats.commits, stats.branches, stats.last.author, stats.last.date))


      -- Bloque central: mensaje, arte y opciones, todos alineados juntos
      local center_block = {}
      table.insert(center_block, "")
      table.insert(center_block, msg) -- solo el texto, highlight se aplica después
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
      local center_line_indices = {}
      for i = 1, total_lines do
        local l = left[i] or ""
        local c = center_block[i] or ""
        table.insert(lines, l .. c)
        center_line_indices[i] = #l
      end

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      -- Aplicar highlights reales SOLO en la columna central
      -- Frase motivacional: buscar la línea que contiene la frase en la parte central
      local frase_line = nil
      local frase_start = nil
      for i = 1, total_lines do
        local l = lines[i]
        local c = center_block[i] or ""
        -- Buscar la frase solo en la parte central de la línea
        local start_col = center_line_indices[i]
        if c == msg and #c > 0 then
          frase_line = i - 1
          frase_start = start_col
          break
        elseif l and msg and #msg > 0 then
          local s, e = l:find(msg, 1, true)
          if s and s >= (start_col + 1) then
            frase_line = i - 1
            frase_start = s - 1
            break
          end
        end
      end
      if frase_line and frase_start then
        vim.api.nvim_buf_add_highlight(buf, -1, "DashboardFrase", frase_line, frase_start, frase_start + #msg)
      end
      -- Opciones del menú (buscar por patrón SOLO en la columna central)
      for i = 1, total_lines do
        local c = center_block[i] or ""
        local l = lines[i]
        local start_col = center_line_indices[i]
        if c:find("%[n%]  Nuevo archivo") then
          local s, e = c:find("%[n%]")
          if s and e then
            vim.api.nvim_buf_add_highlight(buf, -1, "DashboardMenu", i-1, start_col + s - 1, start_col + e)
          end
        elseif c:find("%[f%]  Buscar archivo") then
          local s, e = c:find("%[f%]")
          if s and e then
            vim.api.nvim_buf_add_highlight(buf, -1, "DashboardMenu", i-1, start_col + s - 1, start_col + e)
          end
        elseif c:find("%[r%]  Recientes") then
          local s, e = c:find("%[r%]")
          if s and e then
            vim.api.nvim_buf_add_highlight(buf, -1, "DashboardMenu", i-1, start_col + s - 1, start_col + e)
          end
        elseif c:find("%[e%]  Explorador") then
          local s, e = c:find("%[e%]")
          if s and e then
            vim.api.nvim_buf_add_highlight(buf, -1, "DashboardMenu", i-1, start_col + s - 1, start_col + e)
          end
        elseif c:find("%[q%]  Salir") then
          local s, e = c:find("%[q%]")
          if s and e then
            vim.api.nvim_buf_add_highlight(buf, -1, "DashboardMenu", i-1, start_col + s - 1, start_col + e)
          end
        end
      end
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
