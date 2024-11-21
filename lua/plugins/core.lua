local colorscheme = require("lazyvim.plugins.colorscheme")
return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
            transparent = true,
        },
    },
    {
        "xiyaowong/transparent.nvim",
    },
    {
        "habamax/vim-godot",
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gleam = {},
            },
        },
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        -- Only load if visiting a file in an Obsidian vault
        event = {
            "BufReadPre " .. vim.fn.expand("~") .. "/Documents/**.md",
            "BufNewFile " .. vim.fn.expand("~") .. "/Documents/**.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "university",
                    path = "~/Documents/University files/uninexusrepo/uninexusrepo/",
                },
            },
            attachments = {
                img_folder = "img",
                -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
                ---@return string
                img_name_func = function()
                    -- Prefix image names with timestamp.
                    return string.format("%s-", os.time())
                end,
            },

            -- Optional, completion of wiki links, local files, and tags
            completion = {
                -- Set to false to disable completion
                nvim_cmp = true,
                -- Trigger completion at 2 chars
                min_chars = 2,
            },

            -- Optional, configure key mappings
            mappings = {
                -- Toggle checkbox
                ["<leader>ch"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
            },

            -- Optional, customize how names/IDs for new notes are created
            note_id_func = function(title)
                -- Create note IDs in a Zettelkasten format with a timestamp and title
                local suffix = ""
                if title ~= nil then
                    -- If title is given, use title
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.time()) .. "-" .. suffix
            end,

            -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground
            open_app_foreground = true,

            -- Optional, configure additional syntax highlighting
            ui = {
                enable = true, -- enable custom highlighting
                update_debounce = 200, -- update highlighting after 200ms of no changes
                -- Define custom highlights
                highlights = {
                    ObsidianTodo = { bold = true },
                    ObsidianDone = { bold = true, fg = "#00ff00" },
                    ObsidianRightArrow = { bold = true },
                    ObsidianTilde = { bold = true },
                    ObsidianRefText = { underline = true },
                    ObsidianExtLinkIcon = { fg = "#c96cff" },
                    ObsidianTag = { italic = true, fg = "#ff9e64" },
                },
            },

            -- Optional, configure template settings
            templates = {
                subdir = "Templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
                -- Define template variables
                substitutions = {
                    yesterday = function()
                        return os.date("%Y-%m-%d", os.time() - 86400)
                    end,
                    tomorrow = function()
                        return os.date("%Y-%m-%d", os.time() + 86400)
                    end,
                },
            },
        },
        config = function(_, opts)
            require("obsidian").setup(opts)

            -- Optional: Set up Telescope picker for searching notes
            vim.keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Find Obsidian File" })
            vim.keymap.set("n", "<leader>og", "<cmd>ObsidianSearch<cr>", { desc = "Search Obsidian Files" })
            vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "New Obsidian Note" })
            vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Show Obsidian Backlinks" })
            vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Insert Obsidian Template" })
        end,
    },
    {
        -- Add image viewing capabilities to Neovim
        "3rd/image.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {
            backend = "kitty", -- More compatible backend (or "kitty" if using Kitty)
            max_width = 100, -- Maximum image width
            max_height = 50, -- Maximum image height
            window_overlap_clear_enabled = true, -- Clear images when windows overlap
            editor_only_render_when_focused = true, -- Only render images when editor is focused
        },
        markdown = {
            enabled = true,
            filetypes = { "markdown" },
            resolve_image_path = function(document_path, image_path, fallback)
                image_path = "/home/davinceyr/Documents/University files/uninexusrepo/uninexusrepo/" .. image_path

                return fallback(document_path, image_path)
            end,
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function(_, opts)
            require("image").setup(opts)

            vim.keymap.set("n", "<leader>ip", "<cmd>ImagePreview<cr>", { desc = "Preview Image" })
            vim.keymap.set("n", "<leader>ic", "<cmd>ImageClear<cr>", { desc = "Clear Images" })
        end,
    },
}
