-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "elixirls", "tailwindcss", "zls" }
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
  root_dir = lspconfig.util.root_pattern("mix.exs", ".git"), -- Define root directory
  settings = {
    elixirLS = {
      dialyzerEnabled = true, -- Enable Dialyzer (type checker)
      fetchDeps = false, -- Fetch dependencies (set true if needed)
    },
  },
}

-- Custom configuration for `tailwindcss`
lspconfig.tailwindcss.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "postcss.config.js", ".git"),
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          -- Add regex patterns for extracting class names (if needed)
          { "class[:]?\\s*['\"]([^'\"]*)['\"]", 1 },
          { "className[:]?\\s*['\"]([^'\"]*)['\"]", 1 },
          { '~H\\".*?class=[\'"](.*?)[\'"]', 1 }, -- Support Phoenix LiveView HEEX
        },
      },
    },
  },
}

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

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
