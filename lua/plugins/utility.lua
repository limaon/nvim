local M = {

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },

  -- undotree
  { "mbbill/undotree", event = "VeryLazy" },

  {
    "NvChad/nvim-colorizer.lua",
    ft = function()
      local plugin = require("lazy.core.config").spec.plugins["nvim-colorizer.lua"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      return opts.filetypes or {}
    end,
    opts = {
      filetypes = { "vue", "css", "scss", "less", "html" },
      buftypes = { "*", "!prompt", "!popup" },
      user_default_options = {
        names = false,
        mode = "virtualtext",
        virtualtext = I.misc.palette .. " ",
      },
    },
  },

}

return M
