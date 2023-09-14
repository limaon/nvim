local U = require("custom.utils")

local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = {
    {
      "<leader>ff",
      "<Cmd>Telescope find_files<CR>",
      desc =
      "Telescope Find files"
    },
    {
      "<leader>fw",
      "<Cmd>Telescope grep_string<CR>",
      desc =
      "Telescope Find word"
    },
    {
      "<leader>fc",
      "<Cmd>Telescope current_buffer_fuzzy_find theme=dropdown<CR>",
      desc =
      "Telescope Fuzzy search"
    },
    {
      "<leader>fb",
      "<Cmd>Telescope buffers<CR>",
      desc =
      "Telescope List buffers"
    },
    {
      "<leader>fd",
      "<Cmd>Telescope diagnostics<CR>",
      desc =
      "Telescope List diagnostics"
    },
    {
      "<leader>fh",
      "<Cmd>Telescope help_tags<CR>",
      desc =
      "Telescope List help tags"
    },
    {
      "<leader>fk",
      "<Cmd>Telescope keymaps<CR>",
      desc =
      "Telescope List all keymaps"
    },
    {
      "<leader>fR",
      "<Cmd>Telescope resume<CR>",
      desc =
      "Telescope Resume"
    },
    {
      "<leader>fs",
      "<Cmd>Telescope lsp_document_symbols<CR>",
      desc =
      "Telescope Goto symbol"
    },
    {
      "<leader>fS",
      U.lsp_symbols("workspace"),
      desc =
      "Lsp Goto symbol (Workspace)"
    },
    -- { "<leader>fs", U.lsp_symbols("document "), desc = "Goto symbol" },
    -- { "<leader>fr", "<Cmd>Telescope oldfiles theme=dropdown <CR>", desc = "Recent files" },
  },
  opts = function()
    local actions = require("telescope.actions")
    local layout_actions = require("telescope.actions.layout")

    return {
      defaults = {
        preview = false,
        prompt_prefix = I.misc.telescope .. " ",
        selection_caret = I.misc.fish .. " ",
        file_ignore_patterns = {
          "%.jpg",
          "%.jpeg",
          "%.png",
          "%.otf",
          "%.ttf",
          "%.DS_Store",
          "%.git/",
          "%.mypy_cache/",
          "dist/",
          "node_modules/",
          "site-packages/",
          "__pycache__/",
          "migrations/",
          "package-lock.json",
          "yarn.lock",
          "pnpm-lock.yaml",
        },
        layout_config = {
          height = 0.9,
          width = 0.9,
          horizontal = {
            preview_cutoff = 120,
            preview_width = 0.6,
          },
          vertical = {
            preview_cutoff = 120,
            preview_height = 0.7,
          },
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-n>"] = actions.cycle_history_next,
            ["<Esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-e>"] = layout_actions.toggle_preview,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          sort_mru = true,
          sort_lastused = true,
          ignore_current_buffer = true,
          mappings = {
            i = { ["<C-x>"] = actions.delete_buffer },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    }
  end,
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        local Config = require("lazy.core.config")
        if Config.plugins["telescope.nvim"] and Config.plugins["telescope.nvim"]._.loaded then
          require("telescope").load_extension("fzf")
        end
      end,
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      keys = {
        {
          "<leader>fg",
          "<Cmd>Telescope live_grep_args theme=dropdown<CR>",
          desc = "Find in files (Grep)"
        },
      },
      config = function()
        require("telescope").load_extension("live_grep_args")
      end,
    },
    {
      "ahmedkhalf/project.nvim",
      keys = {
        { "<leader>fp", "<Cmd>Telescope projects theme=dropdown<CR>", desc = "Recent projects" },
      },
      opts = {
        manual_mode = false,
        patterns = { ".git", "pyproject.toml", "go.mod", "Makefile" },
        show_hidden = true,
      },
      config = function(_, opts)
        require("project_nvim").setup(opts)
        require("telescope").load_extension("projects")
      end,
    },
  },
}

return M
