return {
  {
    'tpope/vim-fugitive',
    branch = 'master',
    config = function()
      vim.o.diffopt = 'vertical'
    end,
  },
}
