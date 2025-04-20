return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    config = function()
      require("copilot").setup({
        suggestion = {enabled = false},
        panel = {enabled = false},
        copilot_node_command = 'node'
        -- filetypes = {
        --   yaml = false,
        --   markdown = false,
        --   help = false,
        --   gitcommit = false,
        --   gitrebase = false,
        --   hgcommit = false,
        --   svn = false,
        --   cvs = false,
        --   ["."] = false,
        -- },
      })
    end,
  },
}
