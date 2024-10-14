local myTint = require("colorful_diff.tint")
local config = require("colorful_diff.config")
local buffer_change = require("colorful_diff.buffer_change")

local M = {}

function M.setup(user_config)
	-- Merge user config with default config
	config.update(user_config or {})

	-- Initialize highlight groups
	myTint.InitHighlightGroup(config.colors.diff, config.colors.origin)
	buffer_change.refresh_cycle = config.refresh_cycle

	-- Set up autocmd to call our function on buffer change and when a file is opened
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufRead" }, {
		pattern = "*",
		callback = buffer_change.on_buffer_change,
	})
end

return M
