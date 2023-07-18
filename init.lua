local g, fn = vim.g, vim.fn

g.mapleader = " "
g.maplocalleader = " "

local defaultNamespace = {
  styles = {},
  settings = {
    metadir = ".vim",
    swapdir = fn.stdpath("cache") .. "/swap",
    undodir = fn.stdpath("cache") .. "/undo",
    backupdir = fn.stdpath("cache") .. "/backup",
  },
}

_G.moduleObject = moduleObject or defaultNamespace

require("custom.config").setup()
