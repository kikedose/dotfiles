return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
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
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', function()
          vim.lsp.buf.hover { border = 'rounded', max_height = 25, max_width = 120 }
        end, opts)
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, opts)
      end,
    })

    local cmp = require('cmp')
    cmp.setup({
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
          -- vim.snippet.expand(args.body)
        end,
      },
      preselect = 'item',
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      window = {
        completion = {
          border = 'rounded',
          winhighlight = 'Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None',
        },
        documentation = {
          border = 'rounded',
          winhighlight = 'Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None',
        },
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        -- Jump to the next snippet placeholder
        ['<C-f>'] = cmp.mapping(function(fallback)
          local luasnip = require('luasnip')
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        -- Jump to the previous snippet placeholder
        ['<C-b>'] = cmp.mapping(function(fallback)
          local luasnip = require('luasnip')
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
    })
  end,
}
