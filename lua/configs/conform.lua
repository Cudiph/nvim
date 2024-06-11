local prettier = { "prettierd", "prettier" }

local opts = {
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
        tex        = { "latexindent" },
        plaintex   = { "latexindent" },
        bib        = { "bibtex-tidy" },
        xml        = { "xmlformat" },
        yaml       = { "yamlfmt" },
    },
}

local function M()
    local conform = require("conform")
    conform.setup(opts)

    conform.formatters["clang-format"] = {
        prepend_args = { "--style", "{IndentWidth: 4}" },
    }
end

return M
