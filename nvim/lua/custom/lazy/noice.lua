-- display error messages as actual "notification" messages
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		cmdline = {
			view = "cmdline",
		},
		messages = {
			view = "mini",
			view_error = "mini",
			view_warn = "mini",
		},
		views = {
			mini = {
				backend = "mini",
				reverse = false,
			},
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		routes = {
			-- filter noisy jdtls lsp progress messages
			{
				filter = {
					event = "lsp",
					kind = "progress",
					cond = function(msg)
						local client = msg.opts and msg.opts.progress and msg.opts.progress.client
						local title = msg.opts and msg.opts.progress and msg.opts.progress.title
						if client == "jdtls" then
							return title == "Validate documents" or title == "Publish Diagnostics"
						end
						if client == "lua_ls" then
							return title == "Diagnosing"
						end
						return false
					end,
				},
				opts = { skip = true }
			}
		}
	}
}
