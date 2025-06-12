-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
vim.cmd[[set completeopt+=menuone,noselect,popup]]

vim.lsp.enable('lua_ls')
vim.lsp.config('ts_ls', {
  init_options = { hostInfo = 'neovim' },
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_markers = {'tsconfig.json', 'jsconfig.json', 'package.json', '.git'},
  single_file_support = true,
  --
  -- on_attach = function(client, bufnr)
  --   vim.lsp.completion.enable(true, client.id, bufnr, {
  --     autotrigger = true,
  --     convert = function(item)
  --       return { abbr = item.label:gsub('%b()', '') }
  --     end,
  --   })
  -- end,
})
vim.lsp.enable('ts_ls')
