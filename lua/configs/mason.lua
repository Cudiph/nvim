local mason_pkgs = {
    ensure_installed = {
        --LSP
        "asm-lsp",
        "awk-language-server",
        "bash-language-server",
        "clangd",
        "csharp-language-server",
        "css-lsp",
        "deno",
        "dockerfile-language-server",
        "gopls",
        "html-lsp",
        "jdtls",
        "json-lsp",
        "lua-language-server",
        "luau-lsp",
        "marksman",
        "phpactor",
        "pyright",
        "rust-analyzer",
        "sqlls",
        "svelte-language-server",
        "texlab",
        "typescript-language-server",
        "yaml-language-server",
        "zls",

        -- DAP
        "cpptools",
        "debugpy",
        "js-debug-adapter",

        -- Linter
        "shellcheck",

        -- Formatter
        "asmfmt",
        "bibtex-tidy",
        "black",
        "clang-format",
        "csharpier",
        "gofumpt",
        "latexindent",
        "nixpkgs-fmt",
        "php-cs-fixer",
        "prettier",
        "prettierd",
        --"rustfmt",
        "shfmt",
        "xmlformatter",
        "yamlfmt",

    },
}

-- Credits to NvChad
function M()
    require("mason").setup {}
    vim.api.nvim_create_user_command("MasonInstallAll", function ()
        if mason_pkgs.ensure_installed and #mason_pkgs.ensure_installed > 0 then
            vim.cmd("MasonInstall " .. table.concat(mason_pkgs.ensure_installed, " "))
        end
    end, {})
end

return M
