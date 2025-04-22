return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",

    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("nconf.snippets.all")
    end,
  },

  {
    'saadparwaiz1/cmp_luasnip',
  }
}
