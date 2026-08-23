return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
	require('nvim-treesitter').setup()

	local parsers = {
	    'lua', 'vim', 'vimdoc', 'query', 'luadoc', 				-- core/config
	    'bash', 'python', 'ruby', 'lua', 					-- shell/scripting
	    'html', 'css', 'scss', 'javascript', 'typescript', 'tsx', 'json', 	-- web
	    'c', 'cpp', 'c_sharp', 'rust', 'go', 'java', 			-- systems/compiled
	    'yaml', 'toml', 'xml',						-- data/config formats
	    'markdown', 'markdown_inline',					-- docs
	    'git_config', 'gitcommit', 'gitignore', 'diff',			-- git
	    'sql', 'dockerfile', 'regex',					-- misc common
	}

	require('nvim-treesitter').install(parsers)

	-- Enable highlighting for installed languages
	vim.api.nvim_create_autocmd('FileType', {
	    pattern = parsers,
	    callback = function()
		vim.treesitter.start()
	    end,
	})

	-- Treesitter-based indentation
	vim.api.nvim_create_autocmd('FileType', {
	    pattern = parsers,
	    callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	    end,
	})

	-- Treesitter-based folding
	vim.opt.foldmethod = 'expr'
	vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	vim.opt.foldenable = false
    end,
}
