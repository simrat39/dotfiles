local nnoremap = function(lhs, rhs, silent)
  vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = silent })
end

local inoremap = function(lhs, rhs)
  vim.api.nvim_set_keymap("i", lhs, rhs, { noremap = true })
end

local vnoremap = function(lhs, rhs)
  vim.api.nvim_set_keymap("v", lhs, rhs, { noremap = true })
end

-- smartquit

nnoremap("qq", '<cmd>lua require("utils/smartquit")()<CR>', true)

-- Use alt + hjkl to resize windows
nnoremap("<M-j>", ":resize -2<CR>")
nnoremap("<M-k>", ":resize +2<CR>")
nnoremap("<M-h>", ":vertical resize -2<CR>")
nnoremap("<M-l>", ":vertical resize +2<CR>")

-- Escape redraws the screen and removes any search highlighting.
nnoremap("<esc>", ":noh<return><esc>")

-- Easy CAPS
inoremap("<c-u>", "<ESC>viwUi")

-- TAB in normal mode will move to text buffer
nnoremap("<TAB>", ":bnext<CR>")
-- SHIFT-TAB will go back
nnoremap("<S-TAB>", ":bprevious<CR>")

-- Better tabbing
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Better window navigation
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Map Ctrl-Backspace to delete the previous word in insert mode.
inoremap("<C-w>", "<C-\\><C-o>dB")
inoremap("<C-BS>", "<C-\\><C-o>db")

-- Symbols Outline
nnoremap("<Leader>s", ":SymbolsOutline<CR>")

-- Ranger
nnoremap("<C-s>", ":RnvimrToggle<CR>")

-- WhichKey
nnoremap("<leader>", ":WhichKey '<Space>'<CR>", true)

-- Comentary
nnoremap("<space>/", '<cmd>lua require("utils/comment")()<CR>')
vnoremap("<space>/", '<cmd>lua require("utils/comment")()<CR>')

-- Nvim-Tree
nnoremap("<C-n>", ":NvimTreeToggle<CR>")
nnoremap("<leader>r", ":NvimTreeRefresh<CR>")
nnoremap("<leader>n", ":NvimTreeFindFile<CR>")

-- LSP
nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", true)
nnoremap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", true)
nnoremap("gr", "<cmd>LspTrouble lsp_references<CR>", true)
nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", true)
nnoremap("<C-space>", "<cmd>lua vim.lsp.buf.hover()<CR>", true)
vnoremap("<C-space>", "<cmd>RustHoverRange<CR>")

nnoremap("ge", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", true)
nnoremap("gE", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", true)
nnoremap("<silent><leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", true)
nnoremap("<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", true)
nnoremap("<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", true)
vnoremap("<Leader>a", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")

nnoremap("<Leader>ld", "<cmd>LspTrouble lsp_definitions<CR>", true)
nnoremap(
  "<Leader>le",
  "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
  true
)
nnoremap("<Leader>lE", "<cmd>LspTroubleWorkspaceToggle<CR>", true)

-- Telescope
nnoremap("<C-f>", ':lua require("utils/telescope").search_files()<CR>')
nnoremap("/", ':lua require("utils/telescope").search_in_buffer()<CR>')
inoremap(
  "<C-f>",
  '<Esc> :lua require("utils/telescope").search_in_buffer()<CR>'
)
nnoremap(
  "<Leader>fg",
  '<Esc> :lua require("telescope.builtin").live_grep()<CR>'
)
nnoremap(
  "<Leader>fd",
  '<Esc> :lua require("utils/telescope").search_dotfiles()<CR>'
)
