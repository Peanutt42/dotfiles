-- Automatically add matching (, [, {
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require('nvim-autopairs')
		npairs.setup({
			check_ts = true,
			map_bs = false,
		})

		-- deletes entire line if it only consists of whitespace and moves one up, to the end of the line above
		local function smart_bs()
			local function execute_cmd(str)
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes(str, true, false, true),
					"n",
					true
				)
			end

			local line = vim.api.nvim_get_current_line()
			local line_number = vim.api.nvim_win_get_cursor(0)[1]
			local col = vim.api.nvim_win_get_cursor(0)[2]

			if line:match("^%s*$") and col > 0 then
				if line_number == 1 then
					execute_cmd("<C-u>")
				else
					execute_cmd("<C-o>dd")

					if line_number ~= vim.api.nvim_buf_line_count(0) then
						execute_cmd("<Up>")
					end

					execute_cmd("<End>")
				end

				return
			end

			-- default case: fallback to autopairs bs implementation
			local bufnr = vim.api.nvim_get_current_buf()
			vim.api.nvim_feedkeys(
				npairs.autopairs_bs(bufnr),
				"n",
				true
			)
		end

		vim.keymap.set("i", "<BS>", smart_bs, { noremap = true })
	end,
}
