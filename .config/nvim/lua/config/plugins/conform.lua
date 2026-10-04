return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'oxfmt', 'biome-check', 'prettier', stop_after_first = true },
        typescript = { 'oxfmt', 'biome-check', 'prettier', stop_after_first = true },
        javascriptreact = { 'oxfmt', 'biome-check', 'prettier', stop_after_first = true },
        typescriptreact = { 'oxfmt', 'biome-check', 'prettier', stop_after_first = true },
        json = { 'oxfmt', 'biome-check', 'prettier', stop_after_first = true },
        jsonc = { 'oxfmt', 'biome-check', 'prettier', stop_after_first = true },
        css = { 'oxfmt', 'biome-check', 'prettier', stop_after_first = true },
      },
      formatters = {
        ['biome-check'] = {
          require_cwd = true,
        },
      },
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        require('conform').format({ bufnr = args.buf })
      end,
    })
  end,
}
