require('nvim-treesitter')

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        custom_captures = {
            -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
            -- ["property"] = "TSFunction"
        }
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25 -- Debounced time for highlighting nodes in the playground from source code
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"}
    }
}
