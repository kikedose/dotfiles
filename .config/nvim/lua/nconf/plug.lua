-----------------
-----------------
-- PARSER

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "javascript",
    -- The five parsers below should always be installed
    "lua",
    "vim",
    "vimdoc",
    "c",
    "query"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- Autotag && Autopair Plugin Support
  autotag = {
    enable = true,
  },
  autopairs = {
    enable = true
  },
  -- Indentation
  indent = {
    enable = true,
    disable = { "python", "c" } -- these and some other langs don't work well
  },
})

require('tailwind-sorter').setup({
  on_save_enabled = false,
  on_save_pattern = { '*.html', '*.js', '*.jsx', '*.tsx', '*.twig', '*.hbs', '*.php', '*.heex', '*.astro' },
  node_path = 'node',
})

-----------------
-----------------
-- LSP

local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(
  function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
  end
)

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "tsserver",
    "eslint",
    "tailwindcss",
    "lua_ls",
    -- "emmet_ls",
  },
  handlers = {
    lsp_zero.default_setup,
  },
})

require("lspconfig").tsserver.setup({
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

require("nvim-navic").setup({
  icons = {
    File = ' ',
    Module = ' ',
    Namespace = ' ',
    Package = ' ',
    Class = ' ',
    Method = ' ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = ' ',
    Interface = ' ',
    Function = ' ',
    Variable = ' ',
    Constant = ' ',
    String = ' ',
    Number = ' ',
    Boolean = ' ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = ' ',
    EnumMember = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' '
  },
  lsp = {
    auto_attach = true,
    preference = nil,
  },
})

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
-----------------
-----------------
-- AUTOCOMPLETE

local cmp = require('cmp')

cmp.setup({
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  -- Allow <CR> selection
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  })
})

-----------------
-----------------
-- LUALINE

require('lualine').setup({
  theme = 'gruvbox',
  options = {
    icons_enabled = false,
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'diagnostics' },
    lualine_y = { 'filetype' },
    lualine_z = { 'location' }
  },
  tabline = {
    lualine_a = { 'buffers' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'tabs' }
  },
})

-----------------
-----------------
-- COMMENT

require('Comment').setup()

-----------------
-----------------
-- COLOR

require('colorizer').setup()

