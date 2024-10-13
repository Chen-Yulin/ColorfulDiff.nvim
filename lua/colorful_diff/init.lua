local myTint = require("colorful_diff.tint")
myTint.InitHighlightGroup("#444422", "#224444")
local buffer_change = require("colorful_diff.buffer_change")

-- Set up autocmd to call our function on buffer change and when a file is opened
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufRead" }, {
	pattern = "*",
	callback = buffer_change.on_buffer_change,
})
