return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        require('lualine').setup {
          options = {
            icons_enabled = false,
            theme = 'onedark',
            component_separators = { left = '|', right = '|'},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {},
            always_divide_middle = true,
            colored = false,
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff'},
            lualine_c = {
              {
                'filename',
                path = 1,
                file_status = true,
                shorting_target = 40,
                symbols = {
                  modified = ' [+]',
                  readonly = ' [RO]',
                  unnamed = 'Untitled',
                }
              }
            },
            lualine_x = {'filetype', 'encoding'},
            lualine_y = {
              {
                'diagnostics',
                source = {'nvim-lsp'},
              }
            },
            lualine_z = {'location'}
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
          },
          tabline = {},
          extensions = {}
        }
      }
    end
  }
}
