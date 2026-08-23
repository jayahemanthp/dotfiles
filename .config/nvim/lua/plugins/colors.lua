local function enable_transparency()
    local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "FloatBorder",
        "SignColumn",
        "EndOfBuffer",
        "MsgArea",
        "TelescopeNormal",
        "TelescopeBorder",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "WinBar",
        "WinBarNC",
        "StatusLine",
        "TabLine",
        "TabLineFill",
    }

    for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
end

return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {
            style = "night", -- "storm" | "night" | "moon" | "day"
            transparent = true,
            on_highlights = function(hl, c)
                -- Python import highlighting fix
                hl["@keyword.import.python"] = { fg = c.purple, italic = true }
                hl["@module.python"] = { fg = c.blue1 }
                hl["@module.builtin.python"] = { fg = c.cyan }
                hl["@variable.python"] = { fg = c.fg }

                -- Current line highlighting (subtle, transparency-friendly)
                hl.CursorLine = { bg = c.bg_highlight }
                hl.CursorLineNr = { fg = c.blue, bold = true }
            end,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")

            vim.opt.cursorline = true

            enable_transparency()

            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = enable_transparency,
            })
        end,
    },
}
