return {
	-- Autocomplete suggestions
	{
		"saghen/blink.cmp",
		event = 'InsertEnter',
		version = '1.*',
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "super-tab" },
			signature = { enabled = true },
			fuzzy = { implementation = "prefer_rust" },
			completion = {
				ghost_text = {
					enabled = true,
				}
			}
		},
	},
	-- auto-pairs but faster
	{
		'saghen/blink.pairs',
		event = "InsertEnter",
		dependencies = 'saghen/blink.lib',
		version = '0.6.0',
		build = function() require('blink.pairs').download():pwait(60000) end,
		--- @module 'blink.pairs'
		--- @type blink.pairs.Config
		opts = {
		}
	}
}
