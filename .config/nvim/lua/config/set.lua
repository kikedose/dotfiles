-- Clipboard configuration
if vim.fn.has('wsl') == 1 then
  -- WSL: Use win32yank
  vim.g.clipboard = {
    name = 'win32yank',
    copy = {
      ['+'] = { 'win32yank', '-i', '--crlf' },
      ['*'] = { 'win32yank', '-i', '--crlf' },
    },
    paste = {
      ['+'] = { 'win32yank', '-o', '--lf' },
      ['*'] = { 'win32yank', '-o', '--lf' },
    },
    cache_enabled = 0,
  }

  vim.opt.clipboard = 'unnamedplus'
elseif vim.fn.has('unix') == 1 then
  -- Native Linux: Use system clipboard
  vim.opt.clipboard = 'unnamedplus'
elseif vim.fn.has('mac') == 1 then
  -- macOS: Use system clipboard
  vim.opt.clipboard = 'unnamed'
end

vim.opt.mouse = ''
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = {
  eol = '.',
  tab = '>-',
  trail = '~',
  nbsp = '␣',
  extends = '>',
  precedes = '<',
}
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes:1'
vim.opt.scrolloff = 8
vim.opt.showcmd = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.config/nvim/undodir'
vim.opt.undofile = true
