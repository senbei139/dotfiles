language C
scriptencoding utf-8

"dein Scripts-----------------------------
augroup PluginInstall
  autocmd!
  autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END

" Required:
let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' .. substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

if dein#load_state('$HOME/.cache/dein')
  call dein#begin('$HOME/.cache/dein')

  let g:rc_dir = expand('~/.vim/rc')
  let s:toml = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
" read toml file
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------


let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1

" color
syntax enable
set t_Co=256
set background=dark

"tender settings
if (has("termguicolors"))
  set termguicolors
endif
let g:cpp_class_scope_highlight = 1
colorscheme tender

autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none

" display
set encoding=utf-8
set number
set title
set backspace=2
"noremap! ^H <BS>

set laststatus=2
set statusline=%y
set showmatch
set ruler
set nu
set conceallevel=0
let g:vim_json_syntax_concesal=0

" indent
set expandtab
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set shiftwidth=2


" window split
" split right new window
set splitright
" split below new window
set splitbelow

set ttimeoutlen=10
set cmdwinheight=20
" remove blank from endline
autocmd BufWritePre * :%s/\s\+$//ge

" cursor
set nocursorline
if has('vim_starting')
    " blink pipe cursor when input mode
    let &t_SI .= "\e[5 q"
    " blink block cursor when normal mode
    let &t_EI .= "\e[1 q"
endif

" char code
set fileencoding=utf-8 " when save
set fileencodings=ucs-boms,utf-8,euc-jp,cp932,sjis " when read
set fileformats=unix,dos,mac " new line
set ambiwidth=double " prevent Garbled characters

set cursorline

if has("autocmd")
  " sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtab
  autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xml         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
  autocmd FileType julia       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType java        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType json        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType swift       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scss        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sass        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType typescript  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType go          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yaml        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType kotlin      setlocal sw=4 sts=4 ts=4 et
endif

let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'outputter/buffer/opener': 'new',
      \ 'outputter/buffer/into': 1,
      \ 'outputter/buffer/close_on_empty': 1,
      \ }
nnoremap <silent><leader>r :QuickRun<CR>

" undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" search setting
set ignorecase " not distinguish uppercase or lowercase
set smartcase " distinguish only include uppercase
set wrapscan " return first line when search to end
set incsearch " inclement search
set hlsearch " highlight

" copy
set clipboard+=unnamed

" paste
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" complement command
set wildmenu
set wildmode=longest:full,full
set history=100
set showcmd

" mouse
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

" Buffers
set hidden
nnoremap <silent><C-p> :bprevious<CR>
nnoremap <silent><C-n> :bnext<CR>
nnoremap <silent>:ls<CR> :Files<CR>
nnoremap <silent>:bf<CR> :Buffers<CR>
nnoremap <silent><leader>f :Files<CR>
nnoremap <silent><leader>b :Buffers<CR>

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0


" vim-lsp
" let g:lsp_signs_enabled = 1         " enable signs
" let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
" let g:lsp_diagnostics_enabled = 1
" let g:lsp_signs_error = {'text': 'E'}
" let g:lsp_signs_warning = {'text': 'W'}
" let g:lsp_async_completion = 1
" "let g:lsp_log_verbose = 1
" "let g:lsp_log_file = expand("~/vim-lsp.log")
" nnoremap <expr> <silent> <C-]> execute(':LspDefinition') =~ "not supported" ? "\<C-]>" : ":echo<CR>"
" " nnoremap <silent> :LspNextError<CR>
" " nnoremap <silent> :LspPreviousError<CR>


command! Jq :%!jq '.'

" airline
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_theme = 'hybridline'
let g:airline_symbols.branch = ' '
let g:airline#extensions#default#layout = [
	\ [ 'a', 'b', 'c', 'error', 'warning'],
	\ [ 'x', 'y', 'z' ]
	\ ]


" netrw
let g:netrw_liststyle=1
let g:netrw_sort_by='name'
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview=1
let g:netrw_winsize = 70
let g:netrw_maxfilenamelen=70


set diffopt=filler

" open binary file
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END


function! DebugVimspector()
  call vimspector#LaunchWithSettings({'configuration': &filetype.'_file'})
endfunction

command! Dbg call DebugVimspector()


" open browser command, deafult is 'open'
let g:docker_open_browser_cmd = 'open'

" split temrinal windows, can use vert or tab, etc...
" see :h vert
let g:docker_terminal_open = 'bo'

" check plugin's version when plugin loading.
" default is checking.
" If you not want to check, please set 0 to this option.
let g:docker_plugin_version_check = 1

" Set value to 1 can enable using tmux to attach container.
" default value: 0
let g:docker_use_tmux = 1
