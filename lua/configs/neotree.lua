return {
    close_if_last_window = true,
    filesystem = {
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
        hijack_netrw_behavior = "open_default",
    },
    default_component_configs = {
        git_status = {
            symbols = {
                -- Change type
                added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted   = "✖", -- this can only be used in the git_status source
                renamed   = "󰁕", -- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored   = "",
                unstaged  = "󰄱",
                staged    = "",
                conflict  = "",
            },
        },
    },
    window = {
        width = 35,
        mappings = {
            ["o"] = { "toggle_node", nowait = false },
            ["l"] = "open",
            ["d"] = function (state)
                local ask = vim.fn.confirm("Move to trash?", "&Yes\n&No")
                if ask ~= 1 then return end

                local node = state.tree:get_node()
                local path = node:get_id()
                vim.fn.system("send2trash " .. vim.fn.fnameescape(path))
            end,
            ["D"] = "delete",
        },
        fuzzy_finder_mappings = {
            ["<C-j>"] = "move_cursor_down",
            ["<C-k>"] = "move_cursor_up",
        },
    },

}
