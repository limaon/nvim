local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  build = ":CatppuccinCompile",
  opts = {
    flavour = moduleObject.styles.transparent and "mocha" or "macchiato",
    transparent_background = moduleObject.styles.transparent,
    styles = {
      keywords = { "bold" },
      functions = { "italic" },
    },
    integrations = {
      leap = true,
      mason = true,
      which_key = true,
      ts_rainbow = false,
      dap = { enabled = true, enable_ui = true },
      telescope = { enabled = true, style = moduleObject.styles.transparent and nil or "nvchad" },
    },
    custom_highlights = function(colors)
      return {
        -- custom
        PanelHeading = {
          fg = colors.lavender,
          bg = moduleObject.styles.transparent and "NONE" or colors.crust,
          style = { "bold", "italic" },
        },

        -- lazy.nvim
        LazyH1 = {
          bg = moduleObject.styles.transparent and "NONE" or colors.peach,
          fg = moduleObject.styles.transparent and colors.lavender or colors.base,
          style = { "bold" },
        },
        LazyButton = {
          bg = "NONE",
          fg = moduleObject.styles.transparent and colors.overlay0 or colors.subtext0,
        },
        LazyButtonActive = {
          bg = moduleObject.styles.transparent and "NONE" or colors.overlay1,
          fg = moduleObject.styles.transparent and colors.lavender or colors.base,
          style = { " bold" },
        },
        LazySpecial = { fg = colors.sapphire },

        CmpItemMenu = { fg = colors.subtext1 },
        MiniIndentscopeSymbol = { fg = colors.overlay0 },

        FloatBorder = {
          fg = moduleObject.styles.transparent and colors.overlay1 or colors.mantle,
          bg = moduleObject.styles.transparent and "NONE" or colors.mantle,
        },

        FloatTitle = {
          fg = colors.subtext0,
          bg = moduleObject.styles.transparent and "NONE" or colors.mantle,
        },

        CursorLine = {
          bg = "#262a42",
        },

        StatusLine = {
          fg = colors.text,
          bg = colors.surface1,
        },

        StatusLineNC = {
          fg = colors.text,
          bg = colors.surface2,
        },

      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}

return M
