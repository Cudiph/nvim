local catppuccin_o = require("configs.catppuccin")
local conform_o    = require("configs.conform")
local neotree_o    = require("configs.neotree")
local treesitter_o = require("configs.treesitter")
local cmp_cfg      = require("configs.nvim-cmp")
local dap_cfg      = require("configs.nvim-dap")
local gitsigns_cfg = require("configs.gitsigns")
local lsp_cfg      = require("configs.lspconfig")
local lualine_cfg  = require("configs.evil_lualine")
local mason_cfg    = require("configs.mason")

local plugins      = {
    -- Managers
    {
        "williamboman/mason.nvim",
        config = mason_cfg,
    },

    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        config = lsp_cfg,
    },

    -- Core IDE components
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true,            -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        lazy         = false, -- need to always load for netrw hijack to work
        cmd          = "Neotree",
        branch       = "v3.x",
        keys         = {
            { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts         = neotree_o,
    },

    {
        "stevearc/oil.nvim",
        cmd = "Oil",
        opts = {
            default_file_explorer = false,
            delete_to_trash = true,
            columns = {
                "icon",
                "permissions",
                "size",
                "mtime",
            },
            keymaps = {
                ["<BS>"] = "actions.parent",
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "mfussenegger/nvim-dap",
        lazy         = true,
        dependencies = {
            "LiadOz/nvim-dap-repl-highlights",
            {
                "rcarriga/cmp-dap",
                config = function ()
                    require("cmp").setup {
                        enabled = function ()
                            return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
                                or require("cmp_dap").is_dap_buffer()
                        end,
                    }

                    require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                        sources = {
                            { name = "dap" },
                        },
                    })
                end,
            },
            {
                "LiadOz/nvim-dap-repl-highlights",
                config = function ()
                    require("nvim-dap-repl-highlights").setup()
                end,
            },
            {
                "rcarriga/nvim-dap-ui",
                lazy         = true,
                dependencies = { "nvim-neotest/nvim-nio" },
                config       = function ()
                    local dap, dapui = require("dap"), require("dapui")
                    dapui.setup()
                    dap.listeners.after.event_initialized["dapui_config"] = function ()
                        dapui.open()
                    end
                    dap.listeners.before.event_terminated["dapui_config"] = function ()
                        dapui.close()
                    end
                    dap.listeners.before.event_exited["dapui_config"] = function ()
                        dapui.close()
                    end
                end,
            },

        },
        config       = dap_cfg,
    },

    {
        "hrsh7th/nvim-cmp",
        event        = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "petertriho/cmp-git",
            "onsails/lspkind.nvim",
            "rafamadriz/friendly-snippets",
        },
        config       = cmp_cfg,
    },

    {
        "mfussenegger/nvim-lint",
        config = function ()
            require("lint").linters_by_ft = {
                sh = { "shellcheck" },
            }
        end,
    },

    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd   = { "ConformInfo" },
        keys  = {
            {
                -- Customize or remove this keymap to your liking
                "<leader>fm",
                function ()
                    require("conform").format { lsp_fallback = true }
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        opts  = conform_o,
    },

    -- UX
    {
        "nvim-telescope/telescope.nvim",
        tag          = "0.1.8",
        cmd          = "Telescope",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd          = "FzfLua",
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init  = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts  = {},
    },


    {
        "eraserhd/parinfer-rust",
        ft    = { "yuck", "lisp" },
        build = "cargo build --release",
    },

    {
        "numToStr/Comment.nvim",
        event = "BufRead",
        opts  = {},
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config  = true,
    },

    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts  = {
            pre_load = function ()
                -- loading session with neotree opened is buggy
                vim.cmd("Neotree close")
            end,
            post_load = function ()
                -- close oil.nvim buffer
                local bufname = vim.fn.getcwd()
                if vim.fn.bufexists(bufname) == 1 then
                    vim.cmd("BufferDelete " .. bufname)
                end
            end,
        },
    },

    {
        "windwp/nvim-autopairs",
        event  = "InsertEnter",
        config = true,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        main  = "ibl",
        opts  = {},
    },

    {
        "lewis6991/gitsigns.nvim",
        event  = "InsertEnter",
        config = gitsigns_cfg,
    },

    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = true,
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function () vim.fn["mkdp#util#install"]() end,
    },

    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },

    {
        "kevinhwang91/nvim-ufo",
        name = "ufo",
        event = "BufRead",
        opts = {},
        dependencies = {
            "kevinhwang91/promise-async",
        },
    },

    -- Motion
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        opts = {},
    },

    {
        "psliwka/vim-smoothie",
        event = "WinScrolled",
    },

    {
        "max397574/better-escape.nvim",
        event  = "InsertEnter",
        config = function ()
            require("better_escape").setup {
                mapping = { "jk" },
            }
        end,
    },

    {
        "ggandor/leap.nvim",
        lazy = false,
    },

    -- UI / Looks
    {
        "Bekaboo/dropbar.nvim",
        event        = "BufRead",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = lualine_cfg,
    },

    {
        "romgrk/barbar.nvim",
        event        = "BufRead",
        dependencies = {
            "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
            { "tiagovla/scope.nvim", opts = {} },
        },
        init         = function () vim.g.barbar_auto_setup = false end,
        opts         = {
            auto_hide = 1,
            icons = {
                inactive  = { separator = { left = "", right = "" } },
                separator = { left = "", right = "" },
            },
        },
        version      = "^1.0.0", -- optional: only update when a new 1.x version is released
    },

    {
        "norcalli/nvim-colorizer.lua",
        name = "colorizer",
        event = "BufRead",
        opts = { "*" },
    },

    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function ()
            local rainbow_delimiters = require "rainbow-delimiters"
            require("rainbow-delimiters.setup").setup {
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            }
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd   = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        main  = "nvim-treesitter.configs",
        opts  = treesitter_o,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = catppuccin_o,
        config = function (_, opts)
            require("catppuccin").setup(opts)
            vim.cmd("colorscheme catppuccin-mocha")
        end,
    },
}

local lazy_o       = {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "syntax",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
}
local lazypath     = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins, lazy_o)

return plugins
