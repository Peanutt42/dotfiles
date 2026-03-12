-- Autocomplete suggestions
return {
	"saghen/blink.cmp",
	event = 'VimEnter',
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
}
