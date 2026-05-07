return {
	'chomosuke/typst-preview.nvim',
	lazy = false,
	version = '1.*',
	opts = {
		-- chrome, because i dont use chrome for anything else -> doesnt hijack my zen browser window
		open_cmd = 'com.google.Chrome %s'
	},
}
