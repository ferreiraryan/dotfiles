return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2', -- Recomendo a versão 2, é mais estável
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- Coloque seus atalhos aqui dentro
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end)
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
  end,
}
