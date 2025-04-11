-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- List of LSP servers
local servers = { "html", "cssls", "elixirls", "tailwindcss", "zls", "ts_ls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Custom configuration for `elixirls`
lspconfig.elixirls.setup {
  cmd = { "/home/pattadon-san/elixir-ls-v0.24.1/language_server.sh" }, -- Replace with the actual path
  root_dir = lspconfig.util.root_pattern("mix.exs", ".git"),           -- Define root directory
  settings = {
    elixirLS = {
      dialyzerEnabled = true, -- Enable Dialyzer (type checker)
      fetchDeps = false,      -- Fetch dependencies (set true if needed)
    },
  },
}

lspconfig.eslint.setup({
  cmd = { "vscode-eslint-language-server", "--stdio" },
  root_dir = lspconfig.util.root_pattern("eslint.config.js", ".eslintrc.js", "package.json", ".git"),
  settings = {
    format = true,
    codeActionOnSave = { enable = true, mode = "all" },
    validate = "on",
    experimental = { useFlatConfig = false }, -- set true only if you're using eslint.config.js
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })

    -- See diagnostics
    print("ESLint attached:", client.name)
  end,
})

lspconfig.zls.setup {
  cmd = { "zls" }, -- Ensure `zls` is in your PATH
  filetypes = { "zig" },
  root_dir = lspconfig.util.root_pattern("build.zig", ".git"),
  settings = {
    zls = {
      enable_snippets = true,
      enable_autofix = true,
    },
  },
}
