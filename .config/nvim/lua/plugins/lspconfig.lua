return {
    'neovim/nvim-lspconfig',
    config = function()

	vim.lsp.config('*', {
	    capabilities = require('blink.cmp').get_lsp_capabilities(),
	})

	-- Per-server overrides (optional, only add what you need to customize)
	vim.lsp.config('lua_ls', {
	    settings = {
		Lua = {
		    diagnostics = { globals = { 'vim' } },
		    workspace = { checkThirdParty = false },
		},
	    },
	})

	vim.lsp.config('rust_analyzer', {
	    settings = {
		['rust-analyzer'] = {
		    checkOnSave = true,
		    cargo = { allFeatures = true },
		    diagnostics = { enable = true },
		},
	    },
	})

	vim.lsp.config('clangd', {
	    cmd = { 'clangd', '--background-index', '--clang-tidy' },
	    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
	})

	vim.lsp.config('marksman', {
	    filetypes = { 'markdown' },
	})

	vim.lsp.config('ltex', {
	    filetypes = { 'markdown', 'text', 'tex', 'gitcommit' },
	    flags = { debounce_text_changes = 300 },
	    -- JDK 17+ enforces an XML entity-expansion size limit that LanguageTool's
	    -- English grammar.xml exceeds, crashing ltex-ls on startup with
	    -- "JAXP00010004 ... exceeded the 100,000 limit". Raise it via JVM flag.
	    cmd_env = {
		JDK_JAVA_OPTIONS = '-Djdk.xml.totalEntitySizeLimit=0',
	    },
	    settings = {
		ltex = {
		    language = 'en-US',
		    additionalRules = { enablePickyRules = true },
		},
	    },
	})

	-- Diagnostics appearance
	vim.diagnostic.config({
	    virtual_text = true,
	    signs = true,
	    underline = true,
	    update_in_insert = false,
	    severity_sort = true,
	})

	-- Keymaps on LSP attach
	vim.api.nvim_create_autocmd('LspAttach', {
	    callback = function(args)
		local bufnr = args.buf
		local map = function(mode, lhs, rhs, desc)
		    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
		map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
		map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
		map('n', 'gr', vim.lsp.buf.references, 'Go to references')
		map('n', 'K', vim.lsp.buf.hover, 'Hover docs')
		map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
		map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
		map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, 'Format buffer')
	    end,
	})
    end,
}
