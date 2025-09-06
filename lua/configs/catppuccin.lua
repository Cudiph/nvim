return {
    term_colors = true,
    transparent_background = true,
    color_overrides = {
        all = require("themes.darkpriccio_override"),
    },
    highlight_overrides = {
        all = function (colors)
            return {
                ["@lsp.mod.readonly.javascript"] = { fg = colors.red },
                ["@lsp.mod.readonly.typescript"] = { fg = colors.red },
            }
        end,
    },
    integrations = {
        barbar = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        gitsigns = true,
        lsp_trouble = true,
        mason = true,
        neotree = true,
        noice = true,
        rainbow_delimiters = true,
        treesitter = true,
        ufo = true,
        which_key = true,
        dropbar = {
            enabled = true,
            color_mode = true,
        },
        indent_blankline = {
            enabled = true,
            scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
            colored_indent_levels = false,
        },
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
        telescope = {
            enabled = true,
            style = "nvchad",
        },
        fzf = true,
        leap = true,
    },
}
