local M = {
  {
    "svrana/neosolarized.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "tjdevries/colorbuddy.nvim" },
    config = function ()
      local neosolarized, colorbuddy = require("neosolarized"), require("colorbuddy.init")
      neosolarized.setup({
        comment_italics = true,
        background_set = false,
      })
      local Color = colorbuddy.Color
      local colors = colorbuddy.colors
      local Group = colorbuddy.Group
      local groups = colorbuddy.groups
      local styles = colorbuddy.styles

      Color.new('black', '#000000')
      Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
      Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
      Group.new('Visual', colors.none, colors.base03, styles.reverse)
      Group.new("NormalFloat", colors.base0, Color.none)

      local cError = groups.Error.fg
      local cInfo = groups.Information.fg
      local cWarn = groups.Warning.fg
      local cHint = groups.Hint.fg

      Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
      Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
      Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
      Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

    end,
  },
}

return M
