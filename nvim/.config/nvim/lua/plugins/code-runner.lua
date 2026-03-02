return {
  'CRAG666/code_runner.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'RunCode', 'RunFile', 'RunProject', 'RunClose' },
  keys = {
    { '<F5>', ':RunCode<CR>', desc = 'Run Code' },
  },
  config = function()
    require('code_runner').setup {
      -- Foca no modo float ou tab para não bagunçar seu layout de janelas
      focus = true,
      startinsert = true,
      term = {
        position = 'botright',
        size = 12,
      },
      filetype = {
        java = {
          'cd $dir &&',
          'javac $fileName &&',
          'java $fileNameWithoutExt',
        },
        python = 'python3 -u',
        cpp = {
          'cd $dir &&',
          'g++ $fileName -o $fileNameWithoutExt &&',
          './$fileNameWithoutExt',
        },
        c = {
          'cd $dir &&',
          'gcc $fileName -o $fileNameWithoutExt &&',
          './$fileNameWithoutExt',
        },
      },
    }
  end,
}
