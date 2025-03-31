vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves whole line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves whole line up" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window" })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlights text when yanking",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
