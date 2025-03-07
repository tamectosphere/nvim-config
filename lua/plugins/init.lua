return {
  "nvim-lua/plenary.nvim",
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "nvchad.configs.gitsigns"
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      build = ":TSUpdate", -- Ensures parsers are updated during `:Lazy sync`
      ensure_installed = {
        -- Core languages
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "query",
        "markdown",
        "markdown_inline",

        -- Programming languages
        "elixir", -- Elixir language
        "eex", -- Phoenix templates
        "heex", -- Phoenix LiveView templates
        "javascript", -- JavaScript
        "typescript", -- TypeScript
        "tsx", -- TypeScript JSX (React/Next.js projects)
        "go", -- Go
        "python", -- Python
        "rust", -- Rust

        -- Additional useful languages
        "bash", -- Shell scripts
        "json", -- JSON files
        "yaml", -- YAML files
        "dockerfile", -- Dockerfile
        "toml", -- TOML (used in Rust projects)
        "sql", -- SQL
      },
      highlight = {
        enable = true, -- Enables highlighting
      },
    },
  },

  -- vimtest
  {
    "vim-test/vim-test",
    config = function()
      vim.cmd [[
        function! BufferTermStrategy(cmd)
          exec 'te ' . a:cmd
        endfunction

        let g:test#custom_strategies = {'bufferterm': function('BufferTermStrategy')}
        let g:test#strategy = 'bufferterm'
      ]]
    end,
    keys = {
      { "<leader>Tf", "<cmd>TestFile<cr>", silent = true, desc = "Run this file" },
      { "<leader>Tn", "<cmd>TestNearest<cr>", silent = true, desc = "Run nearest test" },
      { "<leader>Tl", "<cmd>TestLast<cr>", silent = true, desc = "Run last test" },
    },
  },

  -- file explorer
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        -- Sort file names with numbers in a more intuitive order for humans.
        natural_order = "fast",
        -- Sort file and directory names case insensitive
        case_insensitive = false,
        sort = {
          -- sort order can be "asc" or "desc"
          -- see :help oil-columns to see which columns are sortable
          { "type", "asc" },
          { "name", "asc" },
        },
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
  },

  -- linters
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        elixir = { "credo" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  {
    "github/copilot.vim",
    lazy = false,
    config = function() -- Mapping tab is already used by NvChad
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      vim.keymap.set("i", "<A-j>", 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false })
      vim.keymap.del("i", "<Tab>")
      vim.keymap.set("i", "<A-w>", "<Plug>(copilot-accept-word)")
      vim.keymap.set("i", "<A-n>", "<Plug>(copilot-next)")
      -- The mapping is set to other key, see custom/lua/mappings
      -- or run <leader>ch to see copilot mapping section
    end,
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
    config = function()
      require("barbecue").setup {
        create_autocmd = false, -- prevent barbecue from updating itself automatically
      }

      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        -- "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },

  -- animated cursor
  {
    "sphamba/smear-cursor.nvim",
    lazy = false,
    opts = {},
  },

  -- diffview
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      enhanced_diff_hl = true, -- Enable enhanced diff highlighting
    },
    keys = {
      { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>dx", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
      { "<leader>dr", "<cmd>DiffviewRefresh<cr>", desc = "Refresh Diffview" },
    },
    config = function(_, opts)
      require("diffview").setup(opts)
    end,
  },

  -- session management
  {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
    },
  },

  { "tpope/vim-dadbod" },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true, -- Show icons in the signs column
      keywords = {
        FIX = {
          icon = " ", -- Icon for FIX
          color = "error", -- Red
          alt = { "FIXME", "BUG", "ISSUE" },
        },
        TODO = { icon = " ", color = "todo" }, -- Green
        HACK = { icon = " ", color = "hack" }, -- Orange
        WARN = { icon = " ", color = "warn", alt = { "WARNING", "XXX" } }, -- Yellow
        PERF = { icon = " ", color = "perf", alt = { "OPTIMIZE" } }, -- Purple
        NOTE = { icon = " ", color = "note", alt = { "INFO" } }, -- Cyan
      },
      merge_keywords = true,
      highlight = {
        before = "", -- No special background before
        keyword = "wide", -- Highlight the keyword itself
        after = "fg", -- Only foreground color after the keyword
        pattern = [[.*<(KEYWORDS)\s*:]], -- Match pattern for TODO keywords
        comments_only = true, -- Highlight only in comments
        max_line_len = 400, -- Ignore very long lines
      },
      colors = {
        error = "#FF6C6B", -- Vibrant Red for FIX
        todo = "#98C379", -- Green for TODO
        hack = "#00A7AF", -- New teal color for HACK
        warn = "#E5C07B", -- Brighter yellow for WARN (updated)
        perf = "#C678DD", -- Purple for PERF
        note = "#56B6C2", -- Cyan for NOTE
        default = "#ABB2BF", -- Default Grey
      },
    },
    config = function(_, opts)
      require("todo-comments").setup(opts)
    end,
    keys = {
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo (Telescope)" },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons", -- if you prefer nvim-web-devicons
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- Auto-enable rendering when opening Markdown files
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
        pattern = "*.md",
        command = "RenderMarkdown",
      })
    end,
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown<cr>", desc = "Enable Markdown" },
    },

    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = false, -- Search box at the bottom
          command_palette = true, -- Command palette UI
          long_message_to_split = true, -- Split long messages
          inc_rename = false, -- Disable incremental renaming UI
          lsp_doc_border = true, -- Add border to LSP documentation
        },
        notify = {
          enabled = true, -- Use nvim-notify if installed
        },
        commands = {
          history = {
            view = "popup", -- Show message history in a popup
          },
        },
      },
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    },
  },
}
