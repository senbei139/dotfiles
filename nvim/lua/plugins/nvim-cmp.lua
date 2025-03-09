
return {
  {
    "hrsh7th/nvim-cmp", --補完エンジン本体
    dependencies = {
      { "L3MON4D3/LuaSnip" }, --スニペットエンジン
      { "saadparwaiz1/cmp_luasnip" }, --スニペットを補完ソースに
      { "hrsh7th/cmp-nvim-lsp" }, --LSPを補完ソースに
      { "hrsh7th/cmp-buffer" }, --bufferを補完ソースに
      { "hrsh7th/cmp-path" }, --pathを補完ソースに
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ['<C-l>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = 'copilot' },
          { name = "buffer" },
        }),
      })
    end
  }
}
