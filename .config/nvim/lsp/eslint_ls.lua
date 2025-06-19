--- The default `on_attach` config provides the `LspEslintFixAll` command that can be used to format a document on save:
--- ```lua
--- local base_on_attach = vim.lsp.config.eslint.on_attach
--- vim.lsp.config("eslint", {
---   on_attach = function(client, bufnr)
---     if not base_on_attach then return end
---
---     base_on_attach(client, bufnr)
---     vim.api.nvim_create_autocmd("BufWritePre", {
---       buffer = bufnr,
---       command = "LspEslintFixAll",
---     })
---   end,
--- })
local util = vim.lsp.util

return {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
    'svelte',
    'astro',
  },
  root_markers = {
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc.json',
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.cjs',
    'eslint.config.ts',
    'eslint.config.mts',
    'eslint.config.cts',
  },
  workspace_required = true,
  settings = {
    validate = 'on',
    packageManager = nil,
    useESLintClass = false,
    experimental = {
      useFlatConfig = false,
    },
    codeActionOnSave = {
      enable = false,
      mode = 'all',
    },
    format = true,
    quiet = false,
    onIgnoredFiles = 'off',
    rulesCustomizations = {},
    run = 'onType',
    problems = {
      shortenToSingleLine = false,
    },
    nodePath = '',
    workingDirectory = { mode = 'location' },
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = 'separateLine',
      },
      showDocumentation = {
        enable = true,
      },
    },
  },
  before_init = function(_, config)
    local root_dir = config.root_dir

    if root_dir then
      config.settings = config.settings or {}
      config.settings.workspaceFolder = {
        uri = root_dir,
        name = vim.fn.fnamemodify(root_dir, ':t'),
      }

      -- Support flat config
      local flat_config_files = {
        'eslint.config.js',
        'eslint.config.mjs',
        'eslint.config.cjs',
        'eslint.config.ts',
        'eslint.config.mts',
        'eslint.config.cts',
      }

      for _, file in ipairs(flat_config_files) do
        if vim.fn.filereadable(root_dir .. '/' .. file) == 1 then
          config.settings.experimental = config.settings.experimental or {}
          config.settings.experimental.useFlatConfig = true
          break
        end
      end
    end
  end,
  handlers = {
    ['eslint/openDoc'] = function(_, result)
      if result then
        vim.ui.open(result.url)
      end
      return {}
    end,
    ['eslint/confirmESLintExecution'] = function(_, result)
      if not result then
        return
      end
      return 4 -- approved
    end,
    ['eslint/probeFailed'] = function()
      vim.notify('[lspconfig] ESLint probe failed.', vim.log.levels.WARN)
      return {}
    end,
    ['eslint/noLibrary'] = function()
      vim.notify('[lspconfig] Unable to find ESLint library.', vim.log.levels.WARN)
      return {}
    end,
  },
}
