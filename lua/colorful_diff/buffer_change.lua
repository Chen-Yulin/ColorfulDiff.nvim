local myTint = require("colorful_diff.tint")

local M = {}

-- Function to set the highlight namespace for the current window
local function set_window_highlight_namespace(bufnr)
	local winid = vim.fn.bufwinid(bufnr)
	if winid ~= -1 then
		vim.api.nvim_win_set_hl_ns(winid, myTint.ns_id)
	end
end

-- Function to be called when buffer contents change
function M.on_buffer_change()
	local start_time = os.clock()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	-- TODO: Implement diff patch detection logic here
	local diffblocks = M.detect_diff_patch(lines)

	if diffblocks then
		-- Set the highlight namespace for the current window
		set_window_highlight_namespace(bufnr)

		for i, block in ipairs(diffblocks) do
			if i == 1 then
				myTint.clearTint(bufnr, 1, block.diff_start - 1)
			end

			myTint.tintDiff(bufnr, block.diff_start, block.diff_end, true)
			myTint.clearTint(bufnr, block.diff_end + 1, block.origin_start - 1)
			myTint.tintDiff(bufnr, block.origin_start, block.origin_end, false)

			if i < #diffblocks then
				myTint.clearTint(bufnr, block.origin_end + 1, diffblocks[i + 1].diff_start - 1)
			else
				myTint.clearTint(bufnr, block.origin_end + 1, -1)
			end
		end
		local end_time = os.clock()
		-- print("Time taken: ", end_time - start_time)
	end
end

-- Placeholder function for diff patch detection
-- This should be replaced with actual diff patch detection logic
function M.detect_diff_patch(lines)
	local diff_start, diff_end, origin_start, origin_end

	local diffblocks = {}
	local inblock = false
	for i, line in ipairs(lines) do
		if inblock then
			if line:match("^=======") then
				diffblocks[1].diff_end = i - 1
				diffblocks[1].origin_start = i + 1
			elseif line:match("^>>>>>>>") then
				diffblocks[1].origin_end = i - 1
				inblock = false
			end
		else
			if line:match("^<<<<<<<") then
				inblock = true
				table.insert(diffblocks, 1, {
					diff_start = i + 1,
					diff_end = i + 1,
					origin_start = i + 1,
					origin_end = i + 1,
				})
			end
		end
	end

	if #diffblocks > 0 then
		return diffblocks
	end

	return nil -- Return nil if no diff patch is detected
end

return M
