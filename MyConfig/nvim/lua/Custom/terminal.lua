local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}
local function create_window_buffer(opts)
	-- Get the total dimensions of the editor
	opts = opts or {}
	local width = opts.height or math.floor(vim.o.columns * 0.6)
	local height = opts.width or math.floor(vim.o.lines * 0.6)

	-- Calculate the starting position to center the window
	local row = math.floor((vim.o.columns - height) / 2)
	local col = math.floor((vim.o.lines - width) / 2)

	-- Create a temporary buffer for the list
	local buf = nil
	if not vim.api.nvim_buf_is_valid(opts.buf) then
		buf = vim.api.nvim_create_buf(false, true)
	else
		buf = opts.buf
	end
	-- Window options
	local win_opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	}

	-- Open the window
	local win = vim.api.nvim_open_win(buf, true, win_opts)
	if vim.bo.buftype ~= "terminal" then
		vim.cmd.terminal()
	end
	vim.cmd.startinsert()
	-- Optional: Logic to list buffers and switch goes here
	-- For a built-in feel, we often use 'Telescope' (see below)
	return { buf = buf, win = win }
end

function open_terminal()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_window_buffer({ buf = state.floating.buf })
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.keymap.set({ "n", "t" }, "<leader>tt", open_terminal)
