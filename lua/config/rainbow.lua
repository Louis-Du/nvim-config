local is_termux = (os.getenv('PREFIX') or ''):find('com.termux')
if not is_termux then
  local ok, rainbow_delimiters = pcall(require, 'rainbow-delimiters')
  if ok then
    return {
      highlight = rainbow_delimiters.highlight,
    }
  end
end
return {}

vim.g.rainbow_delimiters = {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    vim = rainbow_delimiters.strategy['local'],
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  },
}

