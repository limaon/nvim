local defaultNamespace = {
  styles = {},
  settings = {
    metadir = ".nvim",
    swapdir = vim.fn.stdpath("cache") .. "/swap",
    undodir = vim.fn.stdpath("cache") .. "/undo",
    backupdir = vim.fn.stdpath("cache") .. "/backup",
  },
}

_G.moduleObject = moduleObject or defaultNamespace

require("config").setup()
