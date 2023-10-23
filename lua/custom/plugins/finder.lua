local U = require("custom.utils")

local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fw", "<Cmd>Telescope grep_string<CR>", desc = "Find word" },
    { "<leader>fr", "<Cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    { "<leader>fc", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy search" },
    { "<leader>fb", "<Cmd>Telescope buffers<CR>", desc = "List buffers" },
    { "<leader>fd", "<Cmd>Telescope diagnostics<CR>", desc = "List diagnostics" },
    { "<leader>fk", "<Cmd>Telescope keymaps<CR>", desc = "List keymaps" },
    { "<leader>gb", "<Cmd>Telescope git_branches<CR>", desc = "List branches for git" },
    { "<leader>fs", U.lsp_symbols("document"), desc = "Goto symbol" },
    { "<leader>fS", U.lsp_symbols("workspace"), desc = "Goto symbol (Workspace)" },
    { "<leader>fR", "<Cmd>Telescope resume<CR>", desc = "Resume" },
  },
  opts = function()
    local actions = require("telescope.actions")
    local layout_actions = require("telescope.actions.layout")

    return {
      defaults = {
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
        path_display = { "truncate" },
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
          -- find_command = { "fd" },
          hidden = true,
          previewer = false,
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
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
        U.on_load("telescope.nvim", function()
          require("telescope").load_extension("fzf")
        end)
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
