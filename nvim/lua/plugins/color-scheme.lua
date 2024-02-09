---@type LazySpec
local spec = {
  {
    'bluz71/vim-nightfly-colors',
    config = function()
      vim.cmd.colorscheme("nightfly")
      -- local palette = require("nightfly").palette
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = palette.black })
      -- vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.white, bg = palette.black })
      -- vim.api.nvim_set_hl(0, "PmenuSel", { bg = palette.cyan_blue })
      -- vim.api.nvim_set_hl(0, "LspInlayHint", { link = "Comment" })
    end
  }
}
return spec
