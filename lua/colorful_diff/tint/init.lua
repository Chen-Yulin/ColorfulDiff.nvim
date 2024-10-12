local M = {}

M.ns_id = vim.api.nvim_create_namespace("tint")

M.InitHighlightGroup = function(diffColor, originColor)
	vim.api.nvim_set_hl(0, "TintDiff", { bg = diffColor })
	vim.api.nvim_set_hl(0, "TintOrig", { bg = originColor })
end

M.tintDiff = function(buf, startLine, endLine)
	-- Ensure the buffer exists
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end

	-- Apply the highlight to each line in the range
	for line = startLine, endLine do
		vim.api.nvim_buf_add_highlight(buf, M.ns_id, "TintDiff", line - 1, 0, -1)
	end
end
M.tintOrig = function(buf, startLine, endLine)
	-- Ensure the buffer exists
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end

	-- Apply the highlight to each line in the range
	for line = startLine, endLine do
		vim.api.nvim_buf_add_highlight(buf, M.ns_id, "TintOrig", line - 1, 0, -1)
	end
end

return M
