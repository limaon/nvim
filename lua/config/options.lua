local o, opt = vim.o, vim.opt
local icons = moduleObject.styles.icons
local settings = moduleObject.settings

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.autoformat = false

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Options for Netrw native file browser
vim.g.netrw_fastbrowse = 0
vim.g.netrw_banner = 0
vim.g.netrw_hide = 1
vim.g.netrw_list_hide = '.git,*.bak,*.swp,*.~,*.tmp,*.temp,node_modules,__pycache__'
vim.g.netrw_liststyle = 0
vim.g.netrw_winsize = 20
vim.g.netrw_localmovecmd = 'mv -f'
vim.g.netrw_localrmdir = 'rm -r'

-- Add asterisks in block comments
opt.formatoptions:append({ "r" })

opt.shell = "bash"

-- Indentation
o.wrap = false
o.smartindent = true
o.autoindent = true
o.breakindent = true

o.expandtab = true
o.shiftwidth = 2
o.shiftround = true

-- line
o.number = true
o.relativenumber = true

o.cursorline = true
o.cursorlineopt = moduleObject.styles.transparent and "number" or "number,line"

-- fold
o.foldlevel = 99
o.foldcolumn = "auto"
o.foldmethod = "marker"
o.foldexpr = "nvim_treesitter#foldexpr()"

-- display
o.signcolumn = "no"
o.smoothscroll = false

-- o.modifiable = true
-- o.fileencoding = "utf-8"

opt.clipboard = "unnamedplus"

o.termguicolors = true

o.cmdheight = 1

o.ruler = false
o.showcmd = true
o.showmode = true

o.laststatus = 2
o.statusline = "%<%f %h%m%r %= %{get(b:,'gitsigns_status','')} %y |" ..
o.encoding .. "| L:%l C:%c P:%P "

o.scrolloff = 10
o.sidescrolloff = 5

o.pumheight = 12

o.completeopt = "menu,menuone,noselect"

opt.fillchars = {
  fold = " ",
  msgsep = " ",
  foldsep = " ",
  foldopen = icons.documents.expanded,
  foldclose = icons.documents.collapsed,
}

o.wildmenu = true
o.wildoptions = "pum"
o.wildignorecase = true
o.wildmode = "longest:full,full"
opt.wildignore:append({ "*.o,*.obj,*.pyc,*.class,**/node_modules/*,**/.git/*" })

-- Match and search
o.incsearch = true
o.smartcase = true
o.ignorecase = true
o.hlsearch = true

-- Timings
o.timeoutlen = 500
o.updatetime = 500

-- Window splitting
o.splitright = true
o.splitbelow = true

o.splitkeep = "cursor"

-- Backup and Swap
o.swapfile = true
o.directory = settings.swapdir

o.undofile = true
o.undodir = settings.undodir

o.backup = true
o.backupdir = moduleObject.settings.backupdir

-- Message output on vim actions
opt.shortmess:append({ W = true, c = true, C = true, t = true, T = true })

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.backspace = { "start", "eol", "indent" }
opt.path:append({ "**" })
