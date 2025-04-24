-- No automatic comment insertion
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Yanking highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlights text when yanking',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Rounded floating windows
vim.diagnostic.config({
  float = {
    border = 'rounded',
    max_width = 80,
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

-- Close all buffers except the current one
function CloseAllBuffersExceptCurrent()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    -- Skip the current buffer
    if buf ~= current_buf then
      -- Check if the buffer is loaded and not modified
      if vim.api.nvim_buf_is_loaded(buf) and not vim.api.nvim_buf_get_option(buf, 'modified') then
        -- Delete the buffer
        vim.api.nvim_buf_delete(buf, { force = false })
      end
    end
  end

  vim.notify('Closed all buffers except current', vim.log.levels.INFO)
end

vim.api.nvim_create_user_command('BufOnly', function()
  CloseAllBuffersExceptCurrent()
end, { desc = 'Close all buffers except current' })

vim.keymap.set('n', '<Leader>bo', CloseAllBuffersExceptCurrent, { desc = 'Close all buffers except current' })

-- Trim Microsoft line endings
function Trim()
  local save = vim.fn.winsaveview()
  vim.cmd('keeppatterns %s/\\s\\+$\\|\\r$//e')
  vim.fn.winrestview(save)

  vim.notify('Trimmed ^M line endings', vim.log.levels.INFO)
end

vim.keymap.set('n', '<Leader>tt', Trim, { desc = 'Trimmed ^M line endings' })
