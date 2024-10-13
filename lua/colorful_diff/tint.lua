local M = {}

M.ns_id = vim.api.nvim_create_namespace("tint")

M.InitHighlightGroup = function(diffColor, originColor)
	vim.api.nvim_set_hl(M.ns_id, "TintDiff", { bg = diffColor })
	vim.api.nvim_set_hl(M.ns_id, "TintOrig", { bg = originColor })
end

M.tintDiff = function(buf, startLine, endLine, diff)
	-- Ensure the buffer exists
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end

	-- Apply the highlight to each line in the range
	for line = startLine, endLine do
		if diff then
			vim.api.nvim_buf_add_highlight(buf, M.ns_id, "TintDiff", line - 1, 0, -1)
		else
			vim.api.nvim_buf_add_highlight(buf, M.ns_id, "TintOrig", line - 1, 0, -1)
		end
	end
end

M.clearTint = function(buf, startLine, endLine)
	-- Ensure the buffer exists
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end

	-- Clear the highlights for the specified range
	-- Subtract 1 from startLine and endLine to convert to 0-indexed
end

return M
