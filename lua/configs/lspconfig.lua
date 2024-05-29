local function on_attach(_, bufnr)
    -- Mappings.
    local opts = function (desc) return { buffer = bufnr, noremap = true, silent = true, desc = desc } end
    local map = vim.keymap.set

    map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code action" })
    map("n", "<space>lD", vim.lsp.buf.declaration, opts "LSP declaration")
    map("n", "<space>ld", vim.lsp.buf.definition, opts "LSP definition")
    map("n", "K", vim.lsp.buf.hover, opts "LSP hover")
    map("n", "<space>li", vim.lsp.buf.implementation, opts "LSP implementation")
    map("n", "<space>lh", vim.lsp.buf.signature_help, opts "LSP signature help")
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts "LSP add workspace folder")
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts "LSP remove workspace folder")
    map("n", "<space>wl", function ()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "LSP show workspace folders")
    map("n", "<space>D", vim.lsp.buf.type_definition, opts "LSP type definition")
    map("n", "<space>ra", vim.lsp.buf.rename, opts "LSP rename")
    map("n", "<space>lr", vim.lsp.buf.references, opts "LSP references")
    map("n", "<space>lf", vim.diagnostic.open_float, opts "LSP diagnostic float")
    map("n", "[d", vim.diagnostic.goto_prev, opts "LSP prev diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, opts "LSP next diagnostic")
    map("n", "<space>lq", vim.diagnostic.setloclist, opts "LSP setloclist")
end

function M()
    local lspconfig = require "lspconfig"
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- if you just want default config for the servers then put them in a table
    local servers = {
        "asm_lsp",
        "awk_ls",
        "bashls",
        "clangd",
        "csharp_ls",
        "cssls",
        "dockerls",
        "gopls",
        "html",
        "jdtls",
        "jsonls",
        "luau_lsp",
        "marksman",
        "phpactor",
        "pyright",
        "rust_analyzer",
        "sqlls",
        "svelte",
        "texlab",
        "tsserver",
        "yamlls",
        "zls",
    }

    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end

    lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "awesome" },
                },
            },
        },
    }
end

return M
