---@type ServerConfig
return {

}



--[[

old lua/custom/lazy/jdtls.lua:


return {
	'mfussenegger/nvim-jdtls',
	config = function()
		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'java',
			callback = function()
				local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
				local cache_dir = vim.fn.stdpath('cache')
				local data_dir = vim.fn.stdpath('data')
				local workspace_dir = cache_dir .. "/jdtls_data/" .. project_name
				local config = {
					-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
					cmd = {
						"java",
						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.protocol=false",
						"-Dlog.level=ERROR",
						"-Xmx1g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens",
						"java.base/java.util=ALL-UNNAMED",
						"--add-opens",
						"java.base/java.lang=ALL-UNNAMED",

						"-jar",
						data_dir ..
						"/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar",
						-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
						-- Must point to the                                                     Change this to
						-- eclipse.jdt.ls installation                                           the actual version

						"-configuration",
						data_dir .. "/mason/packages/jdtls/config_linux",
						-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
						-- Must point to the                      Change to one of `linux`, `win` or `mac`
						-- eclipse.jdt.ls installation            Depending on your system.

						"-data",
						workspace_dir,
					},

					-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
					settings = { java = {} },
				}
				require("jdtls").start_or_attach(config)
			end,
		})
	end,
}

--]]
