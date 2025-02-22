local opt = vim.opt
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

local g_cfg = {
    mapleader = " ",
}

local opt_config = {
    number = true,
    relativenumber = true,
    smartindent = true,
    shiftwidth = 4,
    tabstop = 4,
    expandtab = true,
    undofile = true,
    termguicolors = true,
    laststatus = 3, -- always show statusline
    cursorline = true,
    ignorecase = true,

    -- ufo nvim
    fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:",
    foldcolumn = "0", -- change to one to enable
    foldlevel = 99,
    foldlevelstart = 99,
    foldenable = true,
}

for key, val in pairs(g_cfg) do
    g[key] = val
end

for key, val in pairs(opt_config) do
    opt[key] = val
end

-- Appearance
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })
vim.diagnostic.config {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
        },
    },
}

-- autocmd
autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})

autocmd({ "BufWritePost" }, {
    callback = function ()
        local lint = require("lint")
        lint.try_lint()
    end,
})

-- init
require("plugins")
require("keymaps")
