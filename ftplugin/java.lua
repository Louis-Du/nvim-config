local ok, jdtls = pcall(require, 'jdtls')
if ok then
  local opts = { noremap = true, silent = true, buffer = 0 }
  vim.keymap.set('n', '<leader>tm', function() jdtls.test_nearest_method() end, opts)
  vim.keymap.set('n', '<leader>tc', function() jdtls.test_class() end, opts)
end
