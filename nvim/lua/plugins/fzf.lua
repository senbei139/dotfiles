return {
  {
    'junegunn/fzf',
    branch = 'master',
    build = './install --all',
  },
  {
    'junegunn/fzf.vim',
    dependencies = {
      { 'junegunn/fzf' },
    },
    --init = function()
    --  vim.cmd("colorscheme nightfly")
    --  command! -bang -nargs=* Rg
    --  \ call fzf#vim#grep(
    --  \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
    --  \ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
    --  \ : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
    --  \ <bang>0)
    --end
  }
}
