return {
    adapters = {
        http = {
            ollama = function ()
                local ollama = require("codecompanion.adapters.http.ollama")
                local adapter_utils = require("codecompanion.adapters.utils")

                return require("codecompanion.adapters").extend("ollama", {
                    schema = {
                        num_ctx = { default = 32768 },
                        think = { default = true },
                        keep_alive = { default = "30m" },
                    },

                    env = {
                        url = os.getenv("OLLAMA_API_URL"),
                        api_key = os.getenv("OLLAMA_API_KEY"),
                    },
                    headers = {
                        -- ["Content-Type"] = "application/json",
                        ["Authorization"] = "Bearer ${api_key}",
                    },
                    handlers = {
                        form_messages = function (self, messages)
                            return ollama.handlers.form_messages(self,
                                adapter_utils.merge_system_messages(messages))
                        end,
                    },

                })
            end,
            llamacpp = function ()
                local ollama = require("codecompanion.adapters.http.ollama")
                local adapter_utils = require("codecompanion.adapters.utils")

                return require("codecompanion.adapters").extend("openai_compatible", {
                    formatted_name = "llamacpp",
                    schema = {
                        think = { default = true },
                        keep_alive = { default = "30m" },
                        model = {
                            default = "qwen3.5_9b-mtp",
                            choices = { "qwen3.5_9b-mtp", "gemma4_12b", "qwen3.8_27b-mtp" },
                        },

                    },

                    env = {
                        url = "LLAMACPP_API_URL",
                        api_key = "LLAMACPP_API_TOKEN",
                    },
                    handlers = {
                        form_messages = function (self, messages)
                            return ollama.handlers.form_messages(self,
                                adapter_utils.merge_system_messages(messages))
                        end,

                        parse_message_meta = function (self, data)
                            local extra = data.extra
                            if extra and extra.reasoning_content then
                                data.output.reasoning = { content = extra.reasoning_content }
                                if data.output.content == "" then
                                    data.output.content = nil
                                end
                            end
                            return data
                        end,
                    },

                })
            end,
        },
    },

    interactions = {
        chat = {
            adapter = {
                name = "llamacpp",
                model = "qwen3.5_9b-mtp",
            },
            tools = {
                opts = {
                    approval_mode = "auto",
                },
            },
        },
        inline = {
            adapter = {
                name = "llamacpp",
                model = "qwen3.5_9b-mtp",
            },
        },
    },

    extensions = {
        history = {
            enabled = true,
            opts = {
                summary = {
                    create_summary_keymap = "gbc",
                },
            },
        },

    },


}
