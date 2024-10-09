-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 
-- The stuff here overrides nvconfig.lua
-- See :help nvui for details 
---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "solarized_dark",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}


-- Import the default statusline config to extend it
-- local default_statusline = require("nvchad_ui.statusline.default")

M.ui = {
  statusline = {
    -- Use default theme and separator
    theme = "default",
    separator_style = "default",

    -- The order of statusline modules
    order = { "mode", "fullfile", "git", "%=", "lsp_msg", "%=", "lsp", "cwd", "my_conda_module" },

    -- Custom modules
    modules = {
      my_conda_module = function()
        -- Trim the result and return
        -- https://www.lua.org/pil/22.2.html
        env_name = os.getenv("CONDA_DEFAULT_ENV") -- Remove any trailing newlines or spaces
        return env_name ~= "" and env_name or "No conda env"
      end,

      fullfile = "%F"
    }
  }
}

return M
