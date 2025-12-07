vim.o.termguicolors = true
vim.opt.syntax = 'on'
vim.o.background = dark

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = {'*.svelte'},
	command = 'setlocal syntax=html'
})
