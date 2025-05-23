---@type LazySpec
local spec = {
  {
    "lewis6991/gitsigns.nvim",
    -- event = "VeryLazy",
    event = "BufRead",
    --opts = function()
    config = function()
      local gs = require("gitsigns")
      gs.setup({
        on_attach = function(bufnr)
          local function map(mode, l, r, opts)
            opts = vim.F.if_nil(opts, {})
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          -- Navigates
          map("n", "]g", function()
            if vim.wo.diff then
              return "]g"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })
          map("n", "[g", function()
            if vim.wo.diff then
              return "[g"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })
        end,
      })
    end
        -- signs = {
        --   add          = { text = '│' },
        --   change       = { text = '│' },
        --   delete       = { text = '_' },
        --   topdelete    = { text = '‾' },
        --   changedelete = { text = '~' },
        --   untracked    = { text = '┆' },
        -- },
        -- signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        -- numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        -- linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        -- word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        -- watch_gitdir = {
        --   follow_files = true
        -- },
        -- auto_attach = true,
        -- attach_to_untracked = false,
        -- current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        -- current_line_blame_opts = {
        --   virt_text = true,
        --   virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        --   delay = 1000,
        --   ignore_whitespace = false,
        --   virt_text_priority = 100,
        -- },
        -- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        -- sign_priority = 6,
        -- update_debounce = 100,
        -- status_formatter = nil, -- Use default
        -- max_file_length = 40000, -- Disable if file is longer than this (in lines)
        -- preview_config = {
        --   -- Options passed to nvim_open_win
        --   border = 'single',
        --   style = 'minimal',
        --   relative = 'cursor',
        --   row = 0,
        --   col = 1
        -- },
        -- yadm = {
        --   enable = false
        -- },
  }
}

return spec
