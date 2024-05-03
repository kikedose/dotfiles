local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    module = "telescope"
  },

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  -- LSP
  { "VonHeikemen/lsp-zero.nvim",        branch = "v3.x" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { "L3MON4D3/LuaSnip" },

  -- Format (Prettier Support)
  -- {
  --   'stevearc/conform.nvim',
  --   opts = {},
  -- },

  { "tpope/vim-fugitive" },

  {
    "numToStr/Comment.nvim",
    lazy = false,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    opts = {},
  },

  { "windwp/nvim-ts-autotag" },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = {"│"},
      },
    },
  },

-- Breadcrumbs
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" }
  },

-- Color Highlighter
  {
    "norcalli/nvim-colorizer.lua"
  },

-- Tailwind
  {
    'laytan/tailwind-sorter.nvim',
    dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim'},
    build = 'cd formatter && npm ci && npm run build',
    config = true,
  },
})
