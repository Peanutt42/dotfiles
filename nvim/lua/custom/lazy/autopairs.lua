-- Automatically add matching (, [, {
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		check_ts = true,
		map_bs = false,
	},
	config = function(_, opts)
		local npairs = require('nvim-autopairs')
		npairs.setup(opts)

		-- removes all whitespace in front of cursor if everything is just whitespace infront of the cursor
		-- moves one line up, to the end of that line, inserting the removed whitespace if that line is empty
		local function smart_bs()
			local function fallback()
				local bufnr = vim.api.nvim_get_current_buf()
				vim.api.nvim_feedkeys(
					npairs.autopairs_bs(bufnr),
					"n",
					true
				)
			end

			local row, col = unpack(vim.api.nvim_win_get_cursor(0))
			local line = vim.api.nvim_get_current_line()
			local before_cursor = line:sub(1, col)

			if col > 0 and before_cursor:match("^%s*$") then
				local prev_row = row - 1
				if prev_row < 1 then
					fallback()
					return
				end

				local prev_line =
					vim.api.nvim_buf_get_lines(0, prev_row - 1, prev_row, false)[1]

				local remaining = line:sub(col + 1)

				vim.api.nvim_buf_set_lines(0, row - 1, row, false, {})

				if prev_line == "" then
					prev_line = before_cursor
					vim.api.nvim_buf_set_lines(0, prev_row - 1, prev_row, false, { prev_line })
				end

				local new_line = prev_line .. remaining

				vim.api.nvim_buf_set_lines(0, prev_row - 1, prev_row, false, { new_line })
				vim.api.nvim_win_set_cursor(0, { prev_row, #prev_line })

				return
			end

			fallback()
		end

		vim.keymap.set("i", "<BS>", smart_bs, { noremap = true })
	end,
}
