local config = {
	colors = {
		diff = "#555522",
		origin = "#225555",
	},
}

function config.update(user_config)
	config.colors = vim.tbl_deep_extend("force", config.colors, user_config.colors or {})
end

return config
