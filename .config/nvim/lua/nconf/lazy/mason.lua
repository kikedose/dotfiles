return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  },

  config = function()
    require('mason').setup({
      ensure_installed = {
        'stylua',
        'prettier',
      },
    })
    require('mason-lspconfig').setup({
      ensure_installed = {
        'ts_ls',
        'tailwindcss',
        'html',
        'cssls',
        'jsonls',
        'lua_ls',
        'eslint',
      },
    })

    -- SERVERS
    -- lsp config needs to be called after mason init
    local lsp = require('lspconfig')
    lsp.ts_ls.setup({})
    lsp.tailwindcss.setup({})
    lsp.html.setup({})
    lsp.cssls.setup({})
    lsp.jsonls.setup({})
    lsp.lua_ls.setup({
      settings = {
        Lua = { diagnostics = { globals = { 'vim' } } },
      },
    })
    lsp.eslint.setup({
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
    })
  end,
}
