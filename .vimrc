language C

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

" Required:
filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

"
" Required:
filetype plugin indent on

let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1

" color
syntax enable
set background=dark
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
colorscheme solarized
set t_Co=256


" 表示系
set encoding=utf-8
scriptencoding utf-8
set number
set title
set cindent
set cursorline
set backspace=2
noremap! ^H <BS>

set laststatus=2
set statusline=%y
set showmatch
set ruler
set nu
set conceallevel=0

" indent
" 不可視文字を可視化(タブが「▸-」と表示される)
" set list listchars=tab:>-,extends:>,nbsp:%
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=2 " 画面上でタブ文字が占める幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=2 " smartindentで増減する幅


" 画面分割
" 右に新規windowを作る
set splitright
" 下に新規windowを作る
set splitbelow

set ttimeoutlen=10

" コマンドラインウィンドウ幅
set cmdwinheight=20
" 行末からスペース削除
autocmd BufWritePre * :%s/\s\+$//ge

" カーソル系
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[5 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[1 q"
endif

" 文字コード
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932,sjis " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

if has("autocmd")
  " sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtab
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
endif

" undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" 検索設定
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set hlsearch " 検索結果をハイライト

" コピー
set clipboard+=unnamed

" コマンド補完
set wildmenu " コマンドモードの補完
set wildmode=longest:full,full
set history=100 " 保存するコマンド履歴の数
set showcmd

" マウス有効化
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

" ペースト
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

" Buffers
set hidden

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" for markdonw preview
let g:previm_open_cmd = 'open -a Google\ Chrome'


" vim-lsp
let g:lsp_async_completion = 1
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand("~/vim-lsp.log")
let g:lsp_diagnostics_enabled = 1
nnoremap <expr> <silent> <C-]> execute(':LspDefinition') =~ "not supported" ? "\<C-]>" : ":echo<cr>"


" netrw
let g:netrw_liststyle=1
let g:netrw_sort_by='name'
" ヘッダを非表示
" let g:netrw_banner=0
" サイズを(K,M,G)で表示する
let g:netrw_sizestyle="H"
" 日付フォーマットを yyyy/mm/dd(曜日) hh:mm:ss で表示する
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
" プレビューウィンドウを垂直分割で表示する
let g:netrw_preview=1
let g:netrw_winsize = 70


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
