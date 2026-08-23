return {
    {
	'brenoprata10/nvim-highlight-colors',
	config = function()
	    require('nvim-highlight-colors').setup({})
	end
    },
    {
	'mason-org/mason.nvim',
	build = ':MasonUpdate',
	opts = {},
    },
}
