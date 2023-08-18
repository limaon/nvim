local M = {
  {

  },
  {
    --Status column plugin
    --[[ "luukvbaal/statuscol.nvim",
    event = "BufReadPre",
    opts = function()
      local builtin = require("statuscol.builtin")
      local sign_name = { "Diagnostic*", "Dap*", "todo%-sign%-", "neotest_*" }

      return {
        bt_ignore = { "terminal", "nofile" },
        relculright = true,
        segments = {
          { sign = { name = sign_name, maxwidth = 1, auto = true } },
          { text = { builtin.lnumfunc, " " } },
          { sign = { name = { "GitSigns" }, maxwidth = 1, colwidth = 1, auto = true } },
          { text = { builtin.foldfunc, " " } },
        },
      }
    end, ]]
  },
}

return M
