--- Load custom core configs
require("custom.core.options")
---@type ChadrcConfig
local M = {}

M.ui = { theme = 'catppuccin' }
M.plugins = 'custom.plugins'


return M
