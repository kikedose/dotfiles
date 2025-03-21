return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
  },

  config = function()
    local lspconfig_defaults = require('lspconfig').util.default_config
    lspconfig_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lspconfig_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
      )

    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf}

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })

    -----------
    -- SERVERS
    require'lspconfig'.html.setup{}
    require'lspconfig'.cssls.setup{}
    require'lspconfig'.jsonls.setup{}
    require'lspconfig'.tailwindcss.setup{}
    require'lspconfig'.ts_ls.setup{}
    require'lspconfig'.eslint.setup{
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
      end
    }
    -----------

    local cmp = require('cmp')

    cmp.setup({
      sources = {
        {name = "nvim_lsp"},
        {name = "luasnip"},
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
          -- vim.snippet.expand(args.body)
        end,
      },
      preselect = 'item',
      completion = {
        completeopt = 'menu,menuone,noinsert'
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        -- Jump to the next snippet placeholder
        ['<C-f>'] = cmp.mapping(function(fallback)
          local luasnip = require('luasnip')
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, {'i', 's'}),
        -- Jump to the previous snippet placeholder
        ['<C-b>'] = cmp.mapping(function(fallback)
          local luasnip = require('luasnip')
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {'i', 's'}),
      }),
    })
  end
}
