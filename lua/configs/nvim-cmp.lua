function M()
    -- Set up nvim-cmp.
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    cmp.setup {
        experimental = {
            ghost_text = true,
        },
        formatting = {
            --fields = { "kind", "abbr", "menu" },
            -- format = function (entry, vim_item)
            --     local kind = require("lspkind").cmp_format { mode = "symbol_text", maxwidth = 50 }(entry,
            --         vim_item)
            --     local strings = vim.split(kind.kind, "%s", { trimempty = true })
            --     kind.kind = " " .. (strings[1] or "") .. " "
            --     kind.menu = "    (" .. (strings[2] or "") .. ")"
            --
            --     return kind
            -- end,

            format = lspkind.cmp_format {
                mode = "symbol_text", -- show only symbol annotations
                maxwidth = 50,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                -- can also be a function to dynamically calculate max width such as
                -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                ellipsis_char = "...",    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                show_labelDetails = true, -- show labelDetails in menu. Disabled by default

                -- The function below will be called before any actual modifications from lspkind
                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                before = function (entry, vim_item)
                    return vim_item
                end,
                menu = ({
                    buffer = "[Buffer] ",
                    nvim_lsp = "[LSP] ",
                    luasnip = "[LuaSnip] ",
                    nvim_lua = "[Lua] ",
                    latex_symbols = "[Latex] ",
                }),
            },

        },
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function (args)
                require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        completion = { -- highlight first item
            completeopt = "menu,menuone,noinsert",
            keyword_length = 2,
        },
        mapping = {
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-c>"] = cmp.mapping.abort(),
            -- ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    -- abort if nothing selected
                    if not cmp.get_selected_entry() then
                        cmp.abort()
                        return
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    else
                        cmp.confirm { select = true }
                    end
                else
                    fallback()
                end
            end),

            ["<Tab>"] = cmp.mapping(function (fallback)
                -- local is_empty = vim.fn.getline("."):gsub("%s+", "")
                -- if is_empty == "" then return fallback() end

                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.locally_jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-Tab>"] = cmp.mapping(function (fallback)
                print("hello")
                print("hello")
            end),

        },
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "path" },
            { name = "buffer" },
            { name = "cmdline" },
            { name = "emoji" },
            { name = "nvim_lua" },
            { name = "luasnip" }, -- For luasnip users.
        }, {
            { name = "buffer" },
        }),
    }

    -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
            { name = "git" },
        }, {
            { name = "buffer" },
        }),
    })
    require("cmp_git").setup()

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
    })
end

return M
