vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.shiftwidth = 2

--  sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtab
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "html",
-- 	callback = function()
-- 		vim.opt_local.shiftwidth = 2
-- 		vim.opt_local.tabstop = 2
-- 	end
-- })
--
--
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	command = "setlocal sw=4 sts=4 ts=4 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	command = "setlocal sw=4 sts=4 ts=4 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "html",
	command = "setlocal sw=4 sts=4 ts=4 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "xml",
	command = "setlocal sw=4 sts=4 ts=4 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "ruby",
	command = "setlocal sw=2 sts=2 ts=2 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "javascript",
	command = "setlocal sw=2 sts=2 ts=2 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "typescript",
	command = "setlocal sw=2 sts=2 ts=2 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "julia",
	command = "setlocal sw=4 sts=4 ts=4 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	command = "setlocal sw=4 sts=4 ts=4 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	command = "setlocal sw=4 sts=4 ts=4 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "scala",
	command = "setlocal sw=2 sts=2 ts=2 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "json",
	command = "setlocal sw=2 sts=2 ts=2 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "swift",
	command = "setlocal sw=4 sts=4 ts=4 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "css",
	command = "setlocal sw=2 sts=2 ts=2 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "scss",
	command = "setlocal sw=2 sts=2 ts=2 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "sass",
	command = "setlocal sw=2 sts=2 ts=2 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	command = "setlocal sw=4 sts=4 ts=4 noexpandtab"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "yaml",
	command = "setlocal sw=2 sts=2 ts=2 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "kotlin",
	command = "setlocal sw=4 sts=4 ts=4 et"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	command = "setlocal sw=2 sts=2 ts=2 et"
})


