local config = {
	colors = {
		origin = "#445522", -- color for the original part
		diff = "#225544", -- color for the incoming change
	},
	refresh_cycle = 250, -- smaller value for higher refresh frequency, will only refresh when the buffer has changed
}

function config.update(user_config)
	config.colors = vim.tbl_deep_extend("force", config.colors, user_config.colors or {})
	local new_refresh_cycle = vim.tbl_get(user_config, "refresh_cycle")
	if new_refresh_cycle ~= nil then
		config.refresh_cycle = new_refresh_cycle
	end
end

return config
