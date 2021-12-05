require("indent_blankline").setup({
  buftype_exclude = { "terminal" },
  filetype_exclude = { "startify", "help", "dashboard", "Outline" },
  indent_blankline_use_treesitter = true,
  indent_blankline_show_current_context = true,
})
