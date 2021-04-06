local tools = require('tools')
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_better,
        ["<C-k>"] = actions.move_selection_worse,
        ["<C-q>"] = actions.send_to_qflist,
        ["<Esc>"] = actions.close
      },
    },
  }
}

require('telescope').load_extension('fzy_native')

tools.set_binding('n', '<C-f>', ':lua require("telescope-utils").search_files()<CR>')

tools.set_binding('n', '/', ':lua require("telescope-utils").search_in_buffer()<CR>')
tools.set_binding('i', '<C-f>', '<Esc> :lua require("telescope-utils").search_in_buffer()<CR>')

tools.set_binding('n', '<Leader>fg', '<Esc> :lua require("telescope.builtin").live_grep()<CR>')

tools.set_binding('n', '<Leader>fd', '<Esc> :lua require("telescope-utils").search_dotfiles()<CR>')
