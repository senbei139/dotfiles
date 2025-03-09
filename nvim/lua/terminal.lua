vim.opt.shell = "zsh"
vim.api.nvim_set_keymap('n', '<leader>t', ':split | resize 15 | terminal<CR>', { noremap = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.cmd 'autocmd TermOpen * startinsert'
vim.cmd 'autocmd TermOpen * setlocal norelativenumber'
vim.cmd 'autocmd TermOpen * setlocal nonumber'


local function save_terminal_mode()
  vim.b.term_mode = vim.api.nvim_get_mode().mode
end

local function restore_terminal_mode()
  if vim.b.term_mode == 't' then
    vim.cmd('startinsert')
  end
end

vim.api.nvim_create_augroup("restore_terminal_mode", { clear = true })

vim.api.nvim_create_autocmd({ "TermEnter", "TermLeave" }, {
  pattern = "term://*",
  callback = save_terminal_mode,
  group = "restore_terminal_mode",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  callback = restore_terminal_mode,
  group = "restore_terminal_mode",
})

local mappings = {
  ["<C-W>n"] = "<cmd>new<cr>",
  ["<C-W>q"] = "<cmd>quit<cr>",
  ["<C-W>c"] = "<cmd>close<cr>",
  ["<C-W>o"] = "<cmd>only<cr>",
  ["<C-W>j"] = "<cmd>wincmd j<cr>",
  ["<C-W>k"] = "<cmd>wincmd k<cr>",
  ["<C-W>h"] = "<cmd>wincmd h<cr>",
  ["<C-W>l"] = "<cmd>wincmd l<cr>",
  ["<C-W>w"] = "<cmd>wincmd w<cr>",
  ["<C-W>W"] = "<cmd>wincmd W<cr>",
  ["<C-W>t"] = "<cmd>wincmd t<cr>",
  ["<C-W>b"] = "<cmd>wincmd b<cr>",
  ["<C-W>p"] = "<cmd>wincmd p<cr>",
  ["<C-W>P"] = "<cmd>wincmd P<cr>",
  ["<C-W>r"] = "<cmd>wincmd r<cr>",
  ["<C-W>R"] = "<cmd>wincmd R<cr>",
  ["<C-W>x"] = "<cmd>wincmd x<cr>",
  ["<C-W>K"] = "<cmd>wincmd K<cr>",
  ["<C-W>J"] = "<cmd>wincmd J<cr>",
  ["<C-W>H"] = "<cmd>wincmd H<cr>",
  ["<C-W>L"] = "<cmd>wincmd L<cr>",
  ["<C-W>T"] = "<cmd>wincmd T<cr>",
  ["<C-W>="] = "<cmd>wincmd =<cr>",
  ["<C-W>-"] = "<cmd>wincmd -<cr>",
  ["<C-W>+"] = "<cmd>wincmd +<cr>",
  ["<C-W>z"] = "<cmd>pclose<cr>",
}

for key, cmd in pairs(mappings) do
  vim.api.nvim_set_keymap("t", key, cmd, { noremap = true, silent = true })
end
