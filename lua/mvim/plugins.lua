local fn = vim.fn
local cmd = vim.cmd
local icons = mo.style.icons

-- Automatically install packer
local install_path = string.format("%s/site/pack/packer/start/packer.nvim", fn.stdpath("data"))
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("Downloading packer.nvim...", vim.log.levels.INFO, { title = "Packer" })
  vim.notify(
    fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }),
    vim.log.levels.INFO,
    { title = "Packer" }
  )
  cmd.packadd({ "packer.nvim", bang = true })
end

-- Use a protected call so we don't error out on first use
local ok, packer = mo.require("packer")
if not ok then
  vim.notify("Plugin manager had not installed.", vim.log.levels.ERROR, { title = "Packer" })
  return
end

-- Install your plugins here
packer.startup({
  function(use)
    use("wbthomason/packer.nvim") -- Have packer manage itself

    use("lewis6991/impatient.nvim")

    use("nvim-lua/plenary.nvim")

    use("nvim-tree/nvim-web-devicons")

    -- schemea/theme
    use({
      "catppuccin/nvim",
      as = "catppuccin",
      run = function()
        require("catppuccin").compile()
      end,
      config = function()
        require("mvim.config.catppuccin").setup()
        vim.cmd.colorscheme("catppuccin")
      end,
    })

    -- status line
    use({
      "nvim-lualine/lualine.nvim",
      after = "catppuccin",
      config = function()
        require("mvim.config.lualine").setup()
      end,
    })

    -- tab
    use({
      "akinsho/bufferline.nvim",
      after = "catppuccin",
      config = function()
        require("mvim.config.bufferline").setup()
      end,
    })

    -- bashboard
    use({
      "goolord/alpha-nvim",
      config = function()
        require("mvim.config.alpha").setup()
      end,
    })

    -- file explorer
    use({
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("mvim.config.nvim-tree").setup()
      end,
    })

    use({
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("mvim.config.neo-tree").setup()
      end,
    })

    -- telescope: search
    use({
      {
        "nvim-telescope/telescope.nvim",
        config = function()
          require("mvim.config.telescope").setup()
        end,
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        after = "telescope.nvim",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        after = "telescope.nvim",
        config = function()
          require("telescope").load_extension("live_grep_args")
        end,
      },
      {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        after = { "telescope.nvim" },
        config = function()
          require("mvim.config.todo-comments").setup()
        end,
      },
      {
        "stevearc/dressing.nvim",
        after = "telescope.nvim",
        config = function()
          require("mvim.config.dressing").setup()
        end,
      },
      {
        "ahmedkhalf/project.nvim",
        after = "telescope.nvim",
        config = function()
          require("mvim.config.project").setup()
        end,
      },
    })

    -- treesitter: highlight
    use({
      {
        "nvim-treesitter/nvim-treesitter",
        run = function()
          vim.schedule(function()
            require("nvim-treesitter.install").update()
          end)
        end,
        config = function()
          require("mvim.config.nvim-treesitter").setup()
        end,
      },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
      },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        after = "nvim-treesitter",
      },
      {
        "andymass/vim-matchup",
        after = "nvim-treesitter",
        config = function()
          vim.g.matchup_matchparen_offscreen = {
            method = "popup",
            fullwidth = 1,
            highlight = "Normal",
          }
        end,
      },
      {
        "windwp/nvim-ts-autotag",
        after = "nvim-treesitter",
      },
      {
        "windwp/nvim-autopairs",
        after = { "nvim-treesitter", "nvim-cmp" },
        config = function()
          require("mvim.config.nvim-autopairs").setup()
        end,
      },
    })

    -- lsp
    use({
      "neovim/nvim-lspconfig",
      {

        "williamboman/mason.nvim",
        config = function()
          require("mvim.config.mason").setup()
        end,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup()
          local util = require("lspconfig.util")
          -- automatic_installation is handled by manager
          util.on_setup = nil
        end,
      },
      "jose-elias-alvarez/null-ls.nvim",
      {
        "ray-x/lsp_signature.nvim",
        config = function()
          require("lsp_signature").setup({
            bind = true,
            fix_pos = false,
            hint_scheme = "Comment",
            handler_opts = { border = mo.style.border.current },
          })
        end,
      },
      "folke/neodev.nvim",
      "b0o/SchemaStore.nvim",
    })

    -- cmp
    use({
      {
        "hrsh7th/nvim-cmp",
        config = function()
          require("mvim.config.nvim-cmp").setup()
        end,
        requires = {
          {
            "L3MON4D3/LuaSnip",
            -- run = "make install_jsregexp",
            config = function()
              require("mvim.config.luasnip").setups()
            end,
          },
          { "hrsh7th/cmp-nvim-lsp" },
        },
      },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } },
    })

    -- comment
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("mvim.config.comment").setup()
      end,
    })

    -- markdown
    use({
      {
        "dhruvasagar/vim-table-mode",
        cmd = { "TableModeToggle" },
        ft = { "markdown" },
      },
      {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        ft = { "markdown" },
        cmd = { "MarkdownPreview", "MarkdownPreviewToggle" },
      },
    })

    -- debug adapter protocol
    use({
      {
        "mfussenegger/nvim-dap",
        module = "dap",
        setup = function()
          require("mvim.config.nvim-dap").setup()
        end,
        config = function()
          require("mvim.config.nvim-dap").config()
        end,
      },
      {
        "rcarriga/nvim-dap-ui",
        after = "nvim-dap",
        config = function()
          require("mvim.config.nvim-dap-ui").setup()
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        after = "nvim-dap",
        config = function()
          require("nvim-dap-virtual-text").setup({ highlight_new_as_changed = true })
        end,
      },
    })

    use({
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end,
    })

    -- undo history
    use("mbbill/undotree")

    -- git
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("mvim.config.gitsigns").setup()
      end,
    })

    -- termnail
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("mvim.config.toggleterm").setup()
      end,
    })

    -- highlight color
    use({
      "NvChad/nvim-colorizer.lua",
      config = function()
        require("mvim.config.nvim-colorizer").setup()
      end,
    })

    use({
      {
        "ggandor/leap.nvim",
        keys = { "s", "S" },
        config = function()
          require("mvim.config.leap").setup()
        end,
      },
      {
        "ggandor/flit.nvim",
        keys = { "f", "F" },
        wants = { "leap.nvim" },
        after = "leap.nvim",
        config = function()
          require("flit").setup({
            labeled_modes = "nvo",
          })
        end,
      },
    })

    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("mvim.config.indent-blankline").setup()
      end,
    })

    use({
      "kevinhwang91/nvim-ufo",
      disable = true,
      requires = "kevinhwang91/promise-async",
      config = function()
        require("mvim.config.nvim-ufo").setup()
      end,
    })

    use({
      "folke/which-key.nvim",
      config = function()
        require("mvim.config.which-key").setup()
      end,
    })

    -- Misc
    use({
      "dstein64/vim-startuptime",
      cmd = { "StartupTime" },
    })
  end,
  config = {
    log = { level = "info" },
    auto_reload_compiled = true,
    display = {
      working_sym = icons.misc.refresh,
      error_sym = icons.misc.cross,
      done_sym = icons.misc.check,
      removed_sym = icons.misc.close,
      moved_sym = icons.misc.arrow_swap,
      header_sym = icons.misc.dash,
      prompt_border = mo.style.border.current,
    },
    git = {
      clone_timeout = 120,
    },
  },
})
