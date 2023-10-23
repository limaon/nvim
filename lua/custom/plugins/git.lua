local M = {
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs", "<Cmd>Git<CR>", desc = "Git status" },
      { "<leader>gw", "<Cmd>Gwrite<CR>", desc = "Git add" },
      { "<leader>gl", "<Cmd>Git log<CR>", desc = "Git log" },
      { "<leader>gp", "<Cmd>Git push -u origin<CR>", desc = "Git push" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        -- add = { text = "▏" },
        -- change = { text = "▏" },
        delete = { text = "" },
        topdelete = { text = "" },
        -- changedelete = { text = "▏" },
        -- untracked = { text = "▏" },
      },
      current_line_blame = false,
      current_line_blame_opts = { virt_text_priority = 100 },
      current_line_blame_formatter = " <author>, <author_time> · <summary> ",
      preview_config = { border = moduleObject.styles.border },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function keymap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        keymap("n", "[g", gs.prev_hunk, "Prev git hunk")
        keymap("n", "]g", gs.next_hunk, "Next git hunk")
        -- Actions
        keymap("n", "<leader>gh", gs.preview_hunk, "Preview hunk")
        -- Text object
        keymap({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>", "Select git hunk")
      end,
    },

  },
}

return M
