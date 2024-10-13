return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      size = 100,
      open_mapping = [[<leader>t]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = 'float',
      close_on_exit = true,
    },
    config = function()
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true
      })

      local lazydocker = Terminal:new({
        cmd = "lazydocker",
        direction = "float",
        hidden = true
      })

      function _lazygitToggle()
        lazygit:toggle()
      end
      function _lazydockerToggle()
        lazydocker:toggle()
      end
    end
  }
}
