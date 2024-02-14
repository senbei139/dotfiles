---@type LazySpec
local spec = {
  {
    'navarasu/onedark.nvim',
    opts = {
    },
    config = function()
      require('onedark').setup {
          -- style = 'dark'
          -- style = 'darker'
          style = 'cool'
          -- style = 'warmer'
      }
      require('onedark').load()
    end,
  }
}
return spec
