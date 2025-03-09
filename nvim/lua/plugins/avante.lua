return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "copilot",
      auto_suggestions_provider = "copilot",

      -- 動作設定
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true,
      },

      -- ウィンドウ設定
      windows = {
        position = "right",  -- サイドバーの位置
        wrap = true,        -- テキストの折り返し
        width = 30,         -- サイドバーの幅
        -- その他の詳細設定は省略
      },
    },
    build = "make",
    -- 依存関係の設定
    dependencies = {
      -- 必須の依存関係
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- オプションの依存関係
      "hrsh7th/nvim-cmp",
      "zbirenbaum/copilot.lua",
    }
  }
}
