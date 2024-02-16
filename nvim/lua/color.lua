vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = {'*.svelte'},
	command = 'setlocal syntax=html'
})
