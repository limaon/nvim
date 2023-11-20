local U = require("util")

local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<Cmd>Telescope live_grep theme=dropdown<CR>", desc = "Grep (root dir)" },
    { "<leader>fw", "<Cmd>Telescope grep_string theme=dropdown<CR>", desc = "Find word" },
    { "<leader>fr", "<Cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    { "<leader>fc", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy search" },
    {
      "<leader>fb",
      "<Cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>",
      desc = "List buffers",
    },
    { "<leader>fd", "<Cmd>Telescope diagnostics<CR>", desc = "List diagnostics" },
    { "<leader>fs", U.finder.lsp_symbols("document"), desc = "Goto symbol" },
    { "<leader>fS", U.finder.lsp_symbols("workspace"), desc = "Goto symbol (Workspace)" },
    { "<leader>fn", U.finder.config_files(), desc = "Neovim config files" },
    { "<leader>f;", "<Cmd>Telescope resume<CR>", desc = "Resume" },
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
          width = function(_, max_columns, _)
            return math.min(max_columns, 80)
          end,
          height = function(_, _, max_lines)
            return math.min(max_lines, 30)
          end,
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


  },
}

return M
