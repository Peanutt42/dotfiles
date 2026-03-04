vim.api.nvim_create_augroup("RustTabs", { clear = true })

-- format rust on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "RustTabs",
	pattern = "*.rs",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})


-- unsets some settings that get overriden by rust-analyzer when editing rust
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})



-- if nvim is opened with a directory argument, hand it to neotree instead
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local arg = vim.fn.argv(0)
		if vim.fn.isdirectory(arg) == 1 then
			vim.cmd("bd")  -- close the directory buffer
			require("neo-tree.command").execute({ action = "focus", dir = arg })
		end
	end,
})
