return {
  'stevearc/conform.nvim',

  config = function()
    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Fallback array: Try Biome first. If skipped or not found, use Prettier.
        javascript = { 'biome', 'prettier', stop_after_first = true },
        typescript = { 'biome', 'prettier', stop_after_first = true },
        javascriptreact = { 'biome', 'prettier', stop_after_first = true },
        typescriptreact = { 'biome', 'prettier', stop_after_first = true },

        -- Biome also handles JSON and CSS very well
        json = { 'biome', 'prettier', stop_after_first = true },
        jsonc = { 'biome', 'prettier', stop_after_first = true },
        css = { 'biome', 'prettier', stop_after_first = true },
      },

      formatters = {
        -- This is the safety net for working across multiple projects.
        -- It tells Conform: ONLY run Biome if a `biome.json` or `biome.jsonc`
        -- is found in the project root. If it's missing, Conform skips Biome
        -- and automatically triggers Prettier.
        biome = {
          require_cwd = true,
        },

        -- Note: If you choose to swap 'biome' for 'biome-check' in the
        -- formatters_by_ft lists above, you need to configure it here instead:
        -- ['biome-check'] = { require_cwd = true },
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
