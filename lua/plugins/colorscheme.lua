local M = {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    styles = {
      sidebars = "normal",
      floats = "transparent",
      underlined = false,
    },

    sidebars = { "qf", "vista_kind", "terminal", "packer" },

    on_highlights = function(hl, c)
      hl.MatchParen = { fg = c.none, bg = c.none, bold = true }
      hl.StatusLine = { fg = c.base04, bg = c.base0 }
      hl.StatusLineNC = { fg = c.base04, bg = c.base00 }

      hl.Visual = { bg = c.cyan700, reverse = false }
      hl.VisualNOS = { bg = c.cyan700, reverse = false }

      hl.LspReferenceText = { underline = false }
      hl.LspReferenceRead = { underline = false }
      hl.LspReferenceWrite = { underline = false }

      hl.TelescopeMatching = { fg = c.orange500 }
      hl.TelescopeSelection = { bg = c.base03, bold = true }
      hl.TelescopePreviewLine = { bg = c.cyan700, bold = true }
      hl.TelescopePromptPrefix = { fg = c.yellow300 }
      hl.TelescopePromptTitle = { bg = c.none, fg = c.base1 }
      hl.TelescopePromptBorder = { bg = c.none, fg = c.cyan500, }
      hl.TelescopeResultsTitle = { bg = c.none, fg = c.base0, }
      hl.TelescopeBorder = { bg = c.none, fg = c.base01 }
      hl.TelescopeSelectionCaret = { bg = c.none, fg = c.none }

      hl.CmpItemMenu = { fg = c.base0, bg = c.none }
      hl.CmpItemAbbrMatch = { fg = c.yellow500, bg = c.none }
      hl.CmpItemAbbrMatchFuzzy = { fg = c.violet500, bg = c.none }
      hl.MiniIndentscopeSymbol = { fg = c.orange700, nocombine = true }
      hl.MsgArea = { fg = c.base0 }
      hl.helpCommand = { fg = c.blue300, bg = c.base03 }

    end,

  },
  config = function(_, opts)
    require("solarized-osaka").setup(opts)
    vim.cmd.colorscheme("solarized-osaka")
  end,
}

return M
