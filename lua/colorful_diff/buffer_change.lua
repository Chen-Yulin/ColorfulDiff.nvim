local myTint = require("colorful_diff.tint")
local vim = vim

local M = {}

local detect_highlight_timer = nil
local refresh_cycle = 250 -- milliseconds

-- Function to set the highlight namespace for the current window
local function set_window_highlight_namespace(bufnr)
	local winid = vim.fn.bufwinid(bufnr)
	if winid ~= -1 then
		vim.api.nvim_win_set_hl_ns(winid, myTint.ns_id)
	end
end

-- Function to be called when buffer contents change
local function detect_and_highlight()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	local diffblocks = M.detect_diff_patch(lines)

	if diffblocks then
		-- Set the highlight namespace for the current window
		set_window_highlight_namespace(bufnr)

		for i, block in ipairs(diffblocks) do
			myTint.clearTint(bufnr, 1, block.origin_s - 1)
			myTint.tintDiff(bufnr, block.origin_s, block.origin_e, false)
			myTint.clearTint(bufnr, block.origin_e + 1, block.diff_s - 1)
			myTint.tintDiff(bufnr, block.diff_s, block.diff_e, true)
			if i == 1 then
				myTint.clearTint(bufnr, block.diff_e + 1, -1)
			elseif i > 1 then
				myTint.clearTint(bufnr, block.diff_e + 1, diffblocks[i - 1].origin_s - 1)
			end
		end
	end
end

function M.on_buffer_change()
	if detect_highlight_timer then
		vim.fn.timer_stop(detect_highlight_timer)
	end

	detect_highlight_timer = vim.fn.timer_start(refresh_cycle, function()
		detect_and_highlight()
		detect_highlight_timer = nil
	end)
end

-- Placeholder function for diff patch detection
-- This should be replaced with actual diff patch detection logic
function M.detect_diff_patch(lines)
	local origin_s, origin_e, diff_s, diff_e

	local diffblocks = {}
	local inblock = false
	for i, line in ipairs(lines) do
		if inblock then
			if line:match("^=======") then
				diffblocks[1].origin_e = i - 1
				diffblocks[1].diff_s = i + 1
			elseif line:match("^>>>>>>>") then
				diffblocks[1].diff_e = i - 1
				inblock = false
			end
		else
			if line:match("^<<<<<<<") then
				inblock = true
				table.insert(diffblocks, 1, {
					origin_s = i + 1,
					origin_e = i + 1,
					diff_s = i + 1,
					diff_e = i + 1,
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
