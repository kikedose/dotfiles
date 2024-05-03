vim.o.background = "dark"

-- Palette Syntax Nodes Overrides

local palette = {
  bg = {
    [0] = "#282828",
    [1] = "#3c3836",
    [2] = "#504945",
    [3] = "#665c54",
    [4] = "#7c6f64",
  },
  fg = {
    [0] = "#fbf1c7",
    [1] = "#ebdbb2",
    [2] = "#d5c4a1",
    [3] = "#bdae93",
    [4] = "#a89984",
  },
  red = {
    d = "#cc241d",
    l = "#fb4934",
  },
  green = {
    d = "#98971a",
    l = "#b8bb26",
  },
  yellow = {
    d = "#d79921",
    l = "#fabd2f",
  },
  blue = {
    d = "#458588",
    l = "#83a598",
  },
  purple = {
    d = "#b16286",
    l = "#d3869b",
  },
  aqua = {
    d = "#689d6a",
    l = "#8ec07c",
  },
  orange = {
    d = "#d65d0e",
    l = "#fe8019",
  },
  gray = {
    d = "#928374",
    l = "#a89984",
  },
}

require("gruvbox").setup({
  transparent_mode = true,
  overrides = {
    ["@punctuation.bracket.javascript"] = { fg = palette.fg[1] },
    ["@punctuation.delimiter.javascript"] = { fg = palette.gray.l },
    -- ["@tag.javascript"] = { fg = palette.green.l },
    -- ["@tag.builtin.javascript"] = { fg = palette.aqua.l },
    ["@tag.attribute.javascript"] = { fg = palette.yellow.l },
    ["@tag.delimiter.javascript"] = { fg = palette.green.l },
    -- ["@keyword.javascript"] = { fg = palette.aqua.d },
    -- ["@keyword.function.javascript"] = { fg = palette.aqua.d },
    -- ["@keyword.import.javascript"] = { fg = palette.aqua.d },
    ["@keyword.conditional.javascript"] = { fg = palette.red.l },
    ["@keyword.return.javascript"] = { fg = palette.red.l },
    -- ["@keyword.coroutine.javascript"] = { fg = palette.red.l },
    -- ["@type.javascript"] = { fg = palette.yellow.l },
    ["@variable.member.javascript"] = { fg = palette.blue.l },
  }
})

vim.cmd("colorscheme gruvbox")
-- vim.cmd("colorscheme rose-pine")
