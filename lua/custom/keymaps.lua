local function keymap(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Select all
keymap('n', '<M-a>', 'gg<S-v>G', { desc = "Select all" })

-- Native tabs
keymap('n', 'te', ':tabedit ', { silent = false })
keymap('n', 'tt', '<Cmd>tabnew<CR>', { silent = true })
keymap('n', 'tn', '<Cmd>tabNext<CR>', { silent = true })
keymap('n', 'tp', '<Cmd>tabprevious<CR>', { silent = true })
keymap('n', 'td', '<Cmd>tabclose<CR>', { silent = true })

-- Buffer moves
keymap('n', '<Tab>', '<Cmd>bnext<CR>', { desc = "Next buffer" })
keymap('n', '<S-Tab>', '<Cmd>bprevious<CR>', { desc = "Preivous buffer" })
keymap('n', '<DELETE>', '<Cmd>bdelete!<CR>', { desc = "Close current" })

-- Move line
keymap("n", "<M-k>", "<Cmd>move .-2<CR>==", { desc = "Move up" })
keymap("n", "<M-j>", "<Cmd>move .+1<CR>==", { desc = "Move down" })
keymap("i", "<M-k>", "<Esc><Cmd>move .-2<CR>==gi", { desc = "Move up" })
keymap("i", "<M-j>", "<Esc><Cmd>move .+1<CR>==gi", { desc = "Move down" })
keymap("v", "<M-k>", ":move '<-2<cr>gv=gv", { desc = "Move up" })
keymap("v", "<M-j>", ":move '>+1<cr>gv=gv", { desc = "Move down" })

-- Split window
keymap("n", "ss", "<C-W>s", { desc = "Split below" })
keymap("n", "sv", "<C-W>v", { desc = "Split right" })

-- Move to window
keymap("n", "sh", "<C-w>h", { desc = "Go to left window" })
keymap("n", "sk", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "sj", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "sl", "<C-w>l", { desc = "Go to right window" })

-- Resize window
keymap("n", "<Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<Left>", "<Cmd>vertical resize -2<CR>", { desc = "Increase window width" })
keymap("n", "<Right>", "<Cmd>vertical resize +2<CR>", { desc = "Decrease window width" })

-- Saner behavior of n and N
keymap("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

keymap("v", ">", ">gv", { desc = "Visual shifting" })
keymap("v", "<", "<gv", { desc = "Visual shifting" })

-- Clear search with <esc>
keymap({ "i", "n" }, "<esc>", "<Cmd>nohlsearch<CR><Esc>", { desc = "Escape and clear hlsearch" })

-- Better up/down
keymap({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move cursor up" })
keymap({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move cursor down" })

-- Open File browser
keymap("n", "<leader>e", "<Cmd>Explore<CR>", { desc = "Open Netrw" })

-- Undotree
keymap('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Open undotree for git" })

-- Replace World
keymap('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
  { silent = false, desc = "Replace word" })
keymap('n', '<leader>x', '<cmd>!chmod +x %<CR>', { desc = "Excutable file" })
