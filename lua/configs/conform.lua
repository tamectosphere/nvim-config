local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" }, -- ✅ for .tsx
    javascriptreact = { "prettier" }, -- ✅ for .jsx
  },

  format_on_save = {
    -- I recommend these options. See :help conform.format for details.
    lsp_format = "fallback",
    timeout_ms = 500,
  },

  formatters = {
    tailwind_prettier = {
      command = "./node_modules/.bin/prettier",
      args = {
        "--stdin-filepath", "$FILENAME",
        "--plugin", "prettier-plugin-tailwindcss",
      },
      stdin = true,
      cwd = require("conform.util").root_file({
        ".prettierrc",
        ".prettierrc.json",
        "package.json",
      }),
      log = true, -- ✅ Add this
    },
  },
}

return options
