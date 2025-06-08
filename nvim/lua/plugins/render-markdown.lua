return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  ft = { "markdown", "markdown.mdx" },
  opts = {
    heading = {
      enabled = false
    },
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
    },
    render_modes = true, -- Render in ALL modes
    file_types = { "markdown" },
    sign = {
      enabled = false, -- Turn off in the status column
    },
  },
}
