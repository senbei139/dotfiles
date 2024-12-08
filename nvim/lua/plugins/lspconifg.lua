return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      -- Loading nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require('lspconfig')

      local use_biome = function()
        return lspconfig.util.root_pattern('biome.json')(vim.fn.getcwd())
      end

      --eslint
      local eslint_opts = {
        capabilities = capabilities,
        cmd = { "npx", "eslint", "." }
      }

      eslint_opts.on_attach = function(client)
        if not use_biome() then
          client.stop(true)
        end
      end

      lspconfig.ruff.setup{
        capabilities = capabilities,
      }
      lspconfig.ts_ls.setup{
        capabilities = capabilities,
      }
      lspconfig.eslint.setup(eslint_opts)
      lspconfig.biome.setup{
        capabilities = capabilities,
        cmd = { "npx", "biome", "lsp-proxy" }
      }
      lspconfig.svelte.setup{
        capabilities = capabilities,
      }
      lspconfig.dartls.setup{
        capabilities = capabilities,
      }
      lspconfig.golsp.setup{
        capabilities = capabilities,
      }

      vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
      vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format()<CR>')
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
      vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
      vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
      vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
      vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
      vim.keymap.set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    end
  }
}
