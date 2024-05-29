function M()
    local dap = require("dap")

    local bin_folder = vim.fn.stdpath("data") .. "/mason/bin/"

    dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = bin_folder .. "OpenDebugAD7",
    }

    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function ()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopAtEntry = true,
            setupCommands = {
                {
                    text = "-enable-pretty-printing",
                    description = "enable pretty printing",
                    ignoreFailures = false,
                },
            },
        },
        {
            name = "Attach to gdbserver :1234",
            type = "cppdbg",
            request = "launch",
            MIMode = "gdb",
            miDebuggerServerAddress = "localhost:1234",
            miDebuggerPath = "/usr/bin/gdb",
            cwd = "${workspaceFolder}",
            program = function ()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            setupCommands = {
                {
                    text = "-enable-pretty-printing",
                    description = "enable pretty printing",
                    ignoreFailures = false,
                },
            },
        },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    dap.adapters.python = {
        type = "executable",
        command = bin_folder .. "debugpy-adapter",
    }

    dap.configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "Launch this file",
            program = "${file}",
        },
    }

    dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "8123",
        executable = {
            command = bin_folder .. "js-debug-adapter",
        },

    }

    dap.configurations.javascript = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require "dap.utils".pick_process,
            cwd = "${workspaceFolder}",
        },
    }
end

return M
