return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
	'mason-org/mason.nvim',
	'neovim/nvim-lspconfig',
    },
    opts = {
	ensure_installed = {
	    'lua_ls',		-- Lua
	    'clangd',		-- C / C++
	    'omnisharp',	-- C#
	    'html',		-- HTML
	    'cssls',		-- CSS
	    'ts_ls',		-- JS / TS
	    'pyright',		-- Python
	    'jsonls',		-- JSON
	    'yamlls',		-- YAML
	    'bashls',		-- Bash
	    'marksman',		-- Markdown
	    'rust_analyzer',	-- Rust
	    'ltex',		-- LanguageTool (LaTex, plain text, etc.)
	},
	automatic_enable = true,
    },
}
