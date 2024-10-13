vim.g.ale_linters = {
    python = {'ruff'},
}

vim.g.ale_fixers = {
  typescript = {'eslint', 'prettier'},
  typescriptreact = {'eslint', 'prettier'}
}

vim.g.ale_fix_on_save = 1
