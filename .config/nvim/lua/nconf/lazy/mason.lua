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
        'lua_ls',
        'html',
        'cssls',
        'jsonls',
        'ts_ls',
        'tailwindcss',
        'eslint',
      },
    })

    -- SERVERS
    -- lsp config needs to be called after mason init
    require('lspconfig').lua_ls.setup({
      settings = {
        Lua = { diagnostics = { globals = { 'vim' } } },
      },
    })
    require('lspconfig').eslint.setup({
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
    })
  end,
}
