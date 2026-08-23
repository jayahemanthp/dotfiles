return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
	'nvim-lua/plenary.nvim',
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
	vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

	-- Global live grep (& dotfiles)
	vim.keymap.set('n', '<leader>fG', function()
	    builtin.live_grep({
		cwd = vim.fn.expand('~'),
	    })
	end, { desc = 'Telescope live grep in ~' })

	vim.keymap.set('n', '<leader>fdg', function()
	    builtin.live_grep({
		search_dirs = {
		    vim.fn.expand('~/.config'),
		    vim.fn.expand('~/.bashrc'),
		    vim.fn.expand('~/.inputrc'),
		},
		additional_args = function()
		    return { '--hidden' }
		end,
	    })
	end, { desc = 'Telescope live grep in dotfiles' })

	-- Global file finder (& dotfiles)
	vim.keymap.set('n', '<leader>fF', function()
	    builtin.find_files({
		cwd = vim.fn.expand('~'),
	    })
	end, { desc = 'Telescope find files in ~' })

	vim.keymap.set('n', '<leader>fdf', function()
	    builtin.live_grep({
		search_dirs = {
		    vim.fn.expand('~/.config'),
		    vim.fn.expand('~/.bashrc'),
		    vim.fn.expand('~/.inputrc'),
		},
		additional_args = function()
		    return { '--hidden' }
		end,
	    })
	end, { desc = 'Telescope find files in dotfiles' })
    end
}
