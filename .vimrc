language C
scriptencoding utf-8

"dein Scripts-----------------------------
augroup PluginInstall
  autocmd!
  autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
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
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
" colorscheme solarized
colorscheme gruvbox
set background=dark
set t_Co=256
let g:ligthline = { 'colorscheme': 'gruvbox' }



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

if has("autocmd")
  " sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtab
  autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xml         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
  autocmd FileType julia       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType java        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType json        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scss        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sass        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType typescript  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType go          setlocal sw=4 sts=4 ts=4
endif

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
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

" Buffers
set hidden

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0


" vim-lsp
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_error = {'text': 'E'}
let g:lsp_signs_warning = {'text': 'W'}
let g:lsp_async_completion = 1
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand("~/vim-lsp.log")
nnoremap <expr> <silent> <C-]> execute(':LspDefinition') =~ "not supported" ? "\<C-]>" : ":echo<cr>"


command! Jq :%!jq '.'

command! Puuid :%!puuid
command! Suuid :%!suuid

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
