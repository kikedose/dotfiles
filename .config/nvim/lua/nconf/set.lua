vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = "eol:.,tab:>-,trail:~,extends:>,precedes:<"
vim.opt.wrap = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 8
vim.opt.showcmd = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true
vim.opt.clipboard = "unnamed"

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase =true

vim.opt.termguicolors = true

vim.opt.showmode = false

vim.diagnostic.config({
  float = {
    border = "rounded",
    max_width = 80,
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- No automatic comment insertion
vim.cmd([[autocmd FileType * set formatoptions-=ro]])
