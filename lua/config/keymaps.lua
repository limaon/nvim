local Util = require("util")
local keymap = vim.keymap.set

-- Select all
keymap('n', '<M-a>', 'gg<S-v>G', { desc = "Select all" })

-- Native tabs
keymap('n', 'te', ':tabedit ', { silent = false })
keymap('n', 'tt', '<Cmd>tabnew<CR>', { silent = true })
keymap('n', 'tn', '<Cmd>tabnext<CR>', { silent = true })
keymap('n', 'tp', '<Cmd>tabprevious<CR>', { silent = true })
keymap('n', 'td', '<Cmd>tabclose<CR>', { silent = true })

-- Buffer
keymap('n', '<Tab>', '<Cmd>bnext<CR>', { desc = "Next buffer" })
keymap('n', '<S-Tab>', '<Cmd>bprevious<CR>', { desc = "Preivous buffer" })
keymap('n', '<DELETE>', '<Cmd>bdelete!<CR>', { desc = "Close current" })


-- Split window
keymap("n", "ss", "<C-W>s", { desc = "Split below" })
keymap("n", "sv", "<C-W>v", { desc = "Split right" })

-- Move to window
keymap("n", "sh", "<C-w>h", { desc = "Go to left window" })
keymap("n", "sk", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "sj", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "sl", "<C-w>l", { desc = "Go to right window" })

-- Resize window
keymap("n", "<M-Up>", "<Cmd>resize -2<CR>", { desc = "Increase window height" })
keymap("n", "<M-Down>", "<Cmd>resize +2<CR>", { desc = "Decrease window height" })
keymap("n", "<M-Left>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })
keymap("n", "<M-Right>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })

keymap("v", ">", ">gv", { desc = "Visual shifting" })
keymap("v", "<", "<gv", { desc = "Visual shifting" })

-- Keep cursor in the middle of the screen
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Keeping search centered
keymap("n", "n", "nzzzv", { desc = "Next search result" })
keymap("n", "N", "Nzzzv", { desc = "Prev search result" })

-- Clear search with <esc>
keymap({ "i", "n" }, "<esc>", "<Cmd>nohlsearch<CR><Esc>", { desc = "Escape and clear hlsearch" })

-- Better UP / DOWN
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines up" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines down" })

-- Keep cursor in place
keymap("n", "J", "mzJ`z", { desc = "Join lines" })

-- Open File browser
keymap("n", "<leader>e", "<Cmd>Explore<CR>", { desc = "Open Netrw" })

-- Undotree
keymap('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Open undotree for git" })

-- Replace World
keymap('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
  { silent = false, desc = "Replace word" })
keymap('n', '<leader>x', '<cmd>!chmod u+x %<CR>', { desc = "Excutable file" })


-- Get terminal
keymap('n', '<leader>tt', '<CMD>split term://bash<CR>', { silent = false, desc = "Horizontal terminal" })
keymap('n', '<leader>tv', '<CMD>vsplit term://bash<CR>', { silent = false, desc = "Vertical terminal" })
keymap('t', '<Esc>', [[<C-\><C-n>]], { silent = true, desc = "Leave insert mode in the terminal" })

-- Code format
keymap({ "n", "v" }, "<leader>cf", function()
  Util.format.format({ force = true })
end, { desc = "Code format" })

-- Toggle options
keymap("n", "<leader>of", function()
  Util.format.toggle()
end, { desc = "Toggle auto format(global)" })

keymap("n", "<leader>oF", function()
  Util.format.toggle(true)
end, { desc = "Toggle auto format(buffer)" })

keymap("n", "<leader>os", function()
  require("util").toggle("spell")
end, { desc = "Toggle spelling" })

keymap("n", "<leader>ow", function()
  require("util").toggle("wrap")
end, { desc = "Toggle word wrap" })
