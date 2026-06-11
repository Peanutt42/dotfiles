return {
	"rmagatti/auto-session",
	lazy = false,
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		-- while it would be nice to have this as true,
		-- enabling this prevents auto_create from taking effect when launching with "nvim .",
		-- as the single directory argument triggers a check whether cwd matches saved session,
		-- which includes a "*|BRANCH_NAME", so the check always fails -> auto create/save is disabled
		git_use_branch_name = false,
		bypass_save_filetypes = { "neo-tree" },
		post_restore_cmds = {
			function()
				require("neo-tree.command").execute({
					action = "show",
					reveal = true
				})
			end
		},
	},
	config = function(_, opts)
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

		require('auto-session').setup(opts)
	end
}
