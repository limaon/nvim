local M = {
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        keys = {
          { "<leader>ll", "<CMD>LspLog<CR>",     desc = "Lsp Log" },
          { "<leader>li", "<CMD>LspInfo<CR>",    desc = "Lsp Info" },
          { "<leader>lr", "<CMD>LspRestart<CR>", desc = "Lsp Restart" },
        },
      },
      "b0o/SchemaStore.nvim",
      {
        "folke/neodev.nvim",
        opts = { experimental = { pathStrict = true } },
      },
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("custom.utils").has("nvim-cmp")
        end,
      },
      {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
          ui = {
            width = 0.8,
            height = 0.8,
            border = moduleObject.styles.border,
            icons = {
              package_installed = moduleObject.styles.icons.plugin.installed,
              package_pending = moduleObject.styles.icons.plugin.pedding,
              package_uninstalled = moduleObject.styles.icons.plugin.uninstalled,
            },
            keymaps = { apply_language_filter = "f" },
          },
        },
      },
    },
    opts = {
      servers = {
        bashls = {},
        dockerls = {},
        cssls = {},
        eslint = {
          on_attach = function()
            require("custom.utils").augroup("AutoFixOnSave", {
              event = "BufWritePre",
              pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.vue" },
              command = function(args)
                local client = vim.lsp.get_active_clients({ bufnr = args.buf, name = "eslint" })[1]
                if client then
                  local diag = vim.diagnostic.get(
                    args.buf,
                    { namespace = vim.lsp.diagnostic.get_namespace(client.id) }
                  )
                  if #diag > 0 then
                    vim.cmd("EslintFixAll")
                  end
                end
              end,
              desc = "Automatically execute `eslint fix` on save",
            })
          end,
        },
        --[[
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                generate = true,
                gc_details = false,
                test = true,
                tidy = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                unusedparams = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              semanticTokens = true,
              directoryFilters = { "-node_modules" },
            },
          },
        },--]]
        jsonls = {
          on_new_config = function(new_config)
            local schemas = require("schemastore").json.schemas()
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, schemas, 1, #schemas)
          end,
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true },
            },
          },
        },
        pylsp = {},
        stylelint_lsp = {
          filetypes = { "css", "less", "scss", "vue" },
          settings = {
            stylelintplus = {
              autoFixOnSave = true,
              autoFixOnformat = true,
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { 'vim' } },
              format = { enable = true },
              telemetry = { enable = false },
              workspace = { checkThirdParty = false },
            },
          },
        },
        volar = {
          -- take over Typescript
          filetypes = {
            "vue",
            "typescript",
            "javascript",
            "javascriptreact",
            "typescriptreact",
          },
        },
        --[[
        yamlls = {
          settings = {
            yaml = {
              validate = true,
              format = { enable = true },
            },
          },
        },--]]
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      -- @type table<string, fun(server:string, opts: table):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    config = function(_, opts)
      require("custom.plugins.lsp.diagnostics").setup()

      require("custom.plugins.lsp.handlers").setup()

      require("custom.utils").on_attach(function(client, buffer)
        -- require("custom.plugins.lsp.format").on_attach(client, buffer)
        require("custom.plugins.lsp.keybinds").on_attach(client, buffer)

        require("custom.plugins.lsp.codelens").on_attach(client, buffer)
        require("custom.plugins.lsp.highlight").on_attach(client, buffer)
      end)

      ---@param server string lsp server name
      local function setup_server(server)
        local config = require("custom.utils").resolve_config(server, opts.servers[server] or {})
        if opts.setup[server] then
          if opts.setup[server](server, config) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, config) then
            return
          end
        end
        require("lspconfig")[server].setup(config)
      end

      local mlsp = require("mason-lspconfig")
      local all_mlsp_servers =
          vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

      local ensure_installed = {} -- @type string[]
      for server, server_opts in pairs(opts.servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mlsp_servers, server) then
            setup_server(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup_server } })
    end,
  },

  --[[
  {
    "ray-x/lsp_signature.nvim",
    event = "BufReadPost",
    opts = {
      bind = true,
      hint_scheme = "Comment",
      handler_opts = { border = moduleObject.styles.border },
    },
  },
  --]]
}

return M
