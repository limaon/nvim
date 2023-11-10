local o, opt = vim.o, vim.opt
local icons = moduleObject.styles.icons
local settings = moduleObject.settings

-- Indentation
o.wrap = false

o.expandtab = true
o.shiftround = true
o.expandtab = true
o.smarttab = true
o.smartindent = true
o.autoindent = true
o.softtabstop = 4
o.shiftwidth = 2
o.breakindent = true

-- Line
o.number = true
o.relativenumber = true
o.numberwidth = 2

o.cursorline = true
o.cursorlineopt = moduleObject.styles.transparent and "number" or "number,line"

-- fold
o.foldlevel = 0
opt.modelines = 1
o.foldcolumn = "auto"
o.foldmethod = "marker"
-- o.foldexpr = "nvim_treesitter#foldexpr()"

-- display
o.signcolumn = "yes"
opt.clipboard = "unnamedplus"
o.smothscroll = false
o.termguicolors = true
o.laststatus = 2
o.scrolloff = 10
o.sidescrolloff = 5
o.pumheight = 12
o.completeopt = "menu,menuone,noselect"
o.confirm = true
o.history = 10
o.autochdir = true
o.colorcolumn = "80"
o.statusline = "%<%f %h%m%r %= %{get(b:,'gitsigns_status','')} %y |" .. vim.o.encoding .. "| L:%l C:%c P:%P "

-- o.guicursor = ''

opt.fillchars = {
  eob = "~",
  fold = " ",
  msgsep = " ",
  foldsep = " ",
  foldopen = icons.documents.expanded,
  foldclose = icons.documents.collapsed,
}

-- Wild in command mode
o.showcmd = true
o.showmode = true
o.cmdheight = 1

o.wildmenu = true
o.wildoptions = "pum"
o.wildignorecase = true
o.wildmode = "longest:full,full"
o.wildignore = "*.o,*.obj,*.pyc,*.class,**/node_modules/*,**/.git/*"

-- Match and search
o.hlsearch = false
o.incsearch = true
o.smartcase = true
o.ignorecase = true
o.inccommand = 'split'
o.splitkeep = 'screen'

-- Timings
o.timeoutlen = 500 -- 300
o.updatetime = 500 -- 250

-- Window splitting
o.splitright = true
o.splitbelow = true

-- Backup and Swap
o.swapfile = true
o.directory = settings.swapdir

o.undofile = true
o.undodir = settings.undodir

o.backup = true
o.backupdir = moduleObject.settings.backupdir

-- Message output on vim actions
opt.shortmess = {
  f = true,
  s = true,
  o = true,
  O = true,
  t = true,
  T = true,
  A = true,
  c = true,
  F = true,
  W = true,
  I = true,
  C = true
}

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
