local prettier = { "prettierd", "prettier" }

return {
    formatters_by_ft = {
        python     = { "black" },
        javascript = { prettier },
        markdown   = { prettier },
        rust       = { "rustfmt" },
        html       = { prettier },
        php        = { "php_cs_fixer" },
        go         = { "gofumpt" },
        sh         = { "shfmt" },
        asm        = { "asmfmt" },
        c          = { "clang-format" },
        cpp        = { "clang-format" },
        cs         = { "csharpier" },
        nix        = { "nixpkgs_fmt" },
        xml        = { "xmlformat" },
        yaml       = { "yamlfmt" },
    },
}
