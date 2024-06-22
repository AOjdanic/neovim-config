-- return {}
return {
  "neovim/nvim-lspconfig",
  lazy = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local lspconfig = require("lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())

    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
      vim.keymap.set("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", opts)
      vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
      vim.keymap.set("n", "gI", require("telescope.builtin").lsp_implementations, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, opts)
      vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, opts)
      vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover)

      vim.keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
      vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
      vim.keymap.set("n", "<leader>[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
      vim.keymap.set("n", "<leader>]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

      vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.cssls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.gopls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    --tailwind
    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    --emmet_ls
    lspconfig.emmet_language_server.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- json
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.tsserver.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.vuels.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = {
        "vue",
      },
    })

    lspconfig.volar.setup({
      capabilities = capabilities,
      filetypes = {
        "vue",
      },
      on_attach = on_attach,
    })

    -- bash
    lspconfig.bashls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.eslint.setup({
      capabilities = capabilities,
      settings = {
        eslint = {
          autoFixOnSave = true,
          format = {
            enable = true,
          },
        },
      },
    })
  end,
}
