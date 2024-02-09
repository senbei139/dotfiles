require("lazy_nvim")
require("indent")

vim.api.nvim_exec('language en_US', true)
vim.api.nvim_exec('lang en_US.UTF-8', true)

vim.g.mapleader = ' '

-- encoding
vim.o.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'


-- window
vim.o.splitright = true
vim.o.splitbelow = true


-- color
vim.opt.syntax = 'on'
vim.o.t_Co = 256
vim.o.background = dark


-- visual
vim.o.visualbell = true
vim.o.number = true
vim.o.showmatch = true
vim.o.matchtime = 1

vim.o.title = true


-- set laststatus=2
vim.o.statusline = "%y"
vim.o.ruler = true
vim.o.nu = true
-- set conceallevel=0
-- let g:vim_json_syntax_concesal=0

vim.o.diffopt = filler

-- search
vim.o.incsearch = true -- inclement search
vim.o.ignorecase = true -- not distinguish uppercase or lowercase
vim.o.smartcase = true -- distinguish only include uppercase
vim.o.wrapscan = true -- return first line when search to end
vim.o.hlsearch = true -- highlight
vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohl<CR>', { noremap = true, silent = true})


-- manipulation
vim.g.mapleader = ' '
vim.opt.clipboard:append{'unnamedplus'}
vim.o.ttimeout = true
vim.o.ttimeoutlen = 30

-- undo
vim.o.persistent_undo = true
vim.opt.directory = vim.fn.expand('~/.vim/swp')
vim.opt.backup = false
vim.opt.writebackup = false
-- vim.opt.backupdir = "~/.vim/backup~"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.vim/undo')


vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', '<Down>', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', '<Up>', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', 'gj', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'gk', 'k', { noremap = true })


vim.o.ttimeoutlen = 10
vim.o.cmdwinheight = 20


-- Buffers
vim.o.hidden = true
vim.api.nvim_set_keymap('n', '<C-p>', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':bnext<CR>',  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', { noremap = true, silent = true })



-- cursor
vim.o.guicursor = 'n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'


-- char code
-- set fileencoding=utf-8 " when save
-- set fileencodings=ucs-boms,utf-8,euc-jp,cp932,sjis " when read
-- set fileformats=unix,dos,mac " new line
-- vim.o.ambiwidth = 'double'


-- complement command
vim.o.wildmenu = true
vim.o.wildmode = 'list:longest,full'
vim.o.history = 100
vim.o.showcmd = true


--  binary file
-- augroup BinaryXXD
--   autocmd!
--   autocmd BufReadPre  *.bin let &binary =1
--   autocmd BufReadPost * if &binary | silent %!xxd -g 1
--   autocmd BufReadPost * set ft=xxd | endif
--   autocmd BufWritePre * if &binary | %!xxd -r | endif
--   autocmd BufWritePost * if &binary | silent %!xxd -g 1
--   autocmd BufWritePost * set nomod | endif
-- augroup END

-- mouse
vim.o.mouse = a

-- netrw
vim.g['netrw_liststyle'] = 1
vim.g['netrw_sort_by'] = 'name'
vim.g['netrw_sizestyle'] = "H"
vim.g['netrw_timefmt'] = "%Y/%m/%d(%a) %H:%M:%S"
vim.g['netrw_preview'] = 1
vim.g['netrw_winsize'] = 70
vim.g['netrw_maxfilenamelen'] = 70


vim.o.diffopt = 'filler'
