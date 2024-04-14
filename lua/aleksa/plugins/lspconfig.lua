return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions) --"[G]oto [D]efinition"
        vim.keymap.set("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- peek definition
        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references) --"[G]oto [R]eferences"
        vim.keymap.set("n", "gI", require("telescope.builtin").lsp_implementations) --"[G]oto [I]mplementation"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration) --"[G]oto [D]eclaration"
        vim.keymap.set("n", "<leader>D", require("telescope.builtin").lsp_type_definitions) --"Type [D]efinition"
        vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols) --"[D]ocument [S]ymbols"
        vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols) --"[W]orkspace [S]ymbols"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename) --"[R]e[n]ame"
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action) --"[C]ode [A]ction"
        vim.keymap.set("n", "K", vim.lsp.buf.hover) --"Hover Documentation"

        vim.keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
        vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
        vim.keymap.set("n", "<leader>pd", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to prev diagnostic in buffer
        vim.keymap.set("n", "<leader>nd", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["emmet_language_server"] = function()
        -- configure emmet language server
        lspconfig["emmet_language_server"].setup({
          capabilities = capabilities,
          filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
            "svelte",
            "vue",
            "typescript",
            "javascript",
          },
        })
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
              workspace = {
                -- make language server aware of runtime files
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                },
              },
            },
          },
        })
      end,
      ["rust_analyzer"] = function()
        lspconfig["rust_analyzer"].setup({
          capabilities = capabilities,
          filetypes = {
            "rust",
          },
        })
      end,
      ["gopls"] = function()
        lspconfig["gopls"].setup({
          capabilities = capabilities,
          filetypes = {
            "go",
          },
        })
      end,
      ["tailwindcss"] = function()
        lspconfig["tailwindcss"].setup({
          capabilities = capabilities,
          filetypes = {
            "typescript",
            "html",
            "typescriptreact",
            "javascriptreact",
            "javascript",
            "css",
            "sass",
            "scss",
            "less",
            "svelte",
            "vue",
            "jsx",
            "tsx",
            "typescriptreact",
          },
        })
      end,
      ["jsonls"] = function()
        lspconfig["jsonls"].setup({
          capabilities = capabilities,
          filetypes = { "json", "jsonc" },
        })
      end,
      ["tsserver"] = function()
        lspconfig["tsserver"].setup({
          capabilities = capabilities,
          filetypes = {
            "typescript",
            "html",
            "typescriptreact",
            "javascriptreact",
            "javascript",
            "jsx",
            "tsx",
            "css",
            "sass",
            "scss",
            "less",
            "svelte",
            "vue",
          },
          -- root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git", "jsconfig.json"),
        })
      end,
      ["bashls"] = function()
        lspconfig["bashls"].setup({
          capabilities = capabilities,
          filetypes = { "sh" },
        })
      end,
      ["dockerls"] = function()
        lspconfig["dockerls"].setup({
          capabilities = capabilities,
        })
      end,
      ["vuels"] = function()
        lspconfig["vuels"].setup({
          capabilities = capabilities,
          filetypes = { "vue" },
        })
      end,
    })
  end,
}
