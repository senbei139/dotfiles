vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygitToggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua _lazydockerToggle()<CR>", { noremap = true, silent = true })
