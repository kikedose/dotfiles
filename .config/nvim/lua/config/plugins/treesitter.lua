return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',

  config = function()
    require('nvim-treesitter').install({
      'javascript',
      'typescript',
      'tsx',
      'json',
      'jsdoc',
      -- 'html',
      -- 'css',
      'regex',
      -- python,
      -- 'lua',
      -- 'vim',
      -- 'vimdoc',
      -- 'c',
      -- 'query',
      'dart',
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'dart',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
