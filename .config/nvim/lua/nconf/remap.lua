vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
vim.keymap.set("n", "<leader>fr", builtin.live_grep, {})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", ":Telescope find_files hidden=true <CR>")

-- Quick Format
vim.keymap.set("n", "<leader>qef", ":EslintFixAll <CR>")
vim.keymap.set("n", "<leader>qff", ":LspZeroFormat <CR>")
vim.keymap.set("n", "<leader>qpf", ":PrettierFormat <CR>")
