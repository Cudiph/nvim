local map = vim.keymap.set

-- General
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })
map("i", "<C-Return>", "<Esc>o", { desc = "Undestructive newline" })
map({ "i", "c" }, "<C-BS>", "<C-w>", { desc = "Delete the word before cursor" })
map("n", "<leader>rn", function ()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-- Leap
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)", { desc = "Leap forward" })
vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)", { desc = "Leap backward" })
vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", { desc = "Leap from window" })

-- Windowing
map("n", "<c-h>", "<c-w>h", { desc = "Go to the left window" })
map("n", "<c-j>", "<c-w>j", { desc = "Go to the down window" })
map("n", "<c-k>", "<c-w>k", { desc = "Go to the up window" })
map("n", "<c-l>", "<c-w>l", { desc = "Go to the right window" })
map("n", "<c-q>", "<cmd>quit<cr>", { desc = "Quit" })

-- Fuzzy finder
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
    { desc = "telescope find all files" })

-- Buffers
map("n", "<tab>", "<cmd>BufferNext<CR>", { desc = "Goto next buffer" })
map("n", "<A-.>", "<cmd>BufferNext<CR>", { desc = "Goto next buffer" })
map("n", "<S-tab>", "<cmd>BufferPrevious<CR>", { desc = "Goto previous buffer" })
map("n", "<A-,>", "<cmd>BufferPrevious<CR>", { desc = "Goto previous buffer" })
map("n", "<leader>x", "<cmd>BufferClose<CR>", { desc = "Close current buffer" })
map("n", "<leader>X", "<cmd>BufferClose!<CR>", { desc = "Close current buffer" })
map("n", "<leader>bp", "<Cmd>BufferPin<CR>", { desc = "Pin/unpin buffer" })
map("n", "<A-S-,>", "<Cmd>BufferMovePrevious<CR>", { desc = "Reorder buffer to left" })
map("n", "<A-S-.>", "<Cmd>BufferMoveNext<CR>", { desc = "Reorder buffer to right" })

-- Terminal
map({ "n", "t" }, "<A-i>", "<cmd>ToggleTerm direction=float name=float<CR>", { desc = "Toggle terminal floating" })
map({ "n", "t" }, "<A-v>", "<cmd>ToggleTerm direction=vertical size=60 name=vertical<CR>",
    { desc = "Toggle terminal floating" })
map({ "n", "t" }, "<A-h>", "<cmd>ToggleTerm direction=horizontal name=horizontal<CR>",
    { desc = "Toggle terminal floating" })
map({ "n", "t" }, "<A-t>", "<cmd>ToggleTerm direction=tab name=tab<CR>", { desc = "Toggle terminal tab" })

-- Session manager
map("n", "<leader>ql", [[<cmd>lua require("persistence").load()<cr>]], { desc = "load session for cwd" })
map("n", "<leader>qa", [[<cmd>lua require("persistence").load({ last = true })<cr>]], { desc = "load last session" })
map("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]],
    { desc = "stop Persistence => session won't be saved on exit" })

-- DAP
map("n", "<leader>dt", function () require("dapui").toggle() end, { desc = "Toggle DAP breakpoint" })
map("n", "<leader>db", function () require("dap").toggle_breakpoint() end, { desc = "Toggle DAP breakpoint" })
map("n", "<leader>dc", function () require("dap").continue() end, { desc = "Continue/start new debugging session" })
map("n", "<leader>ds", function ()
    require("dap").terminate()
    require("dap").close()
    require("dapui").close()
end, { desc = "Stop debugging session" })
map("n", "<F10>", function () require("dap").step_over() end, { desc = "DAP step over" })
map("n", "<F11>", function () require("dap").step_into() end, { desc = "DAP step into" })
map("n", "<F12>", function () require("dap").step_out() end, { desc = "DAP step out" })

-- Files
map("n", "<leader>fs", "<cmd>Oil<CR>", { desc = "Manage files as buffer" })

-- diagnostics view
map("n", "<leader>zx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle Trouble" })
map("n", "<leader>zX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Toggle Trouble" })
map("n", "<leader>zq", "<cmd>Trouble quickfix<cr>", { desc = "Toggle Trouble quickfix" })
map("n", "<leader>zl", "<cmd>Trouble loclist<cr>", { desc = "Toggle Trouble loclist" })
map("n", "<leader>zr", "<cmd>Trouble lsp_references toggle<cr>", { desc = "Toggle Trouble lsp references" })

-- Notifications
map("n", "<leader>nc", "<cmd>NoiceDismiss<cr>", { desc = "Clear all notification" })
