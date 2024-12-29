---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "gruvbox",

  hl_override = {
    -- Set the background color to the exact value from the XML
    Normal = { bg = "#1B1B1B" },
    -- Adjust floating windows, popups, etc.
    NormalFloat = { bg = "#1B1B1B" },
    FloatBorder = { fg = "#504945", bg = "#1B1B1B" },
    -- Set line number background and foreground
    LineNr = { fg = "#3c3836", bg = "#1B1B1B" },
    CursorLineNr = { fg = "#fabd2f", bg = "#1B1B1B" },
    -- Adjust comments to be italic
    Comment = { fg = "#7c6f64", italic = true },
    ["@comment"] = { fg = "#7c6f64", italic = true },
    -- Set statusline or other UI elements
    StatusLine = { fg = "#ebdbb2", bg = "#1B1B1B" },
    StatusLineNC = { fg = "#928374", bg = "#1B1B1B" },
    -- Other elements as needed
    Visual = { bg = "#2a2a2a" },
    Pmenu = { bg = "#1B1B1B", fg = "#d4be98" },
  },
}

return M
