return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },

  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "html", "cssls", "jsonls", "ts_ls", "tailwindcss", "eslint" }
    })

    -- SERVERS
    require("lspconfig").lua_ls.setup {
      settings = {
        Lua = { diagnostics = { globals = { 'vim' } } }
      },
    }
    require("lspconfig").html.setup {}
    require("lspconfig").cssls.setup {}
    require("lspconfig").jsonls.setup {}
    require("lspconfig").tailwindcss.setup {}
    require("lspconfig").ts_ls.setup {}
    require("lspconfig").eslint.setup {
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end
    }
  end
}
