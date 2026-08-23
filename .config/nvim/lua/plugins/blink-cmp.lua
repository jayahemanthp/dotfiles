return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*', -- use the stable release channel

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      menu = {
        border = 'rounded',
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    signature = {
      enabled = true,
      window = { border = 'rounded' },
    },
  },
  opts_extend = { 'sources.default' },
}
