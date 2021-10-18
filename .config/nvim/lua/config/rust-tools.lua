-----------------------
-- Rust
-----------------------
require("rust-tools").setup({
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(
			"/home/simrat39/.vscode/extensions/vadimcn.vscode-lldb-1.6.7/adapter/codelldb",
			"/home/simrat39/.vscode/extensions/vadimcn.vscode-lldb-1.6.7/lldb/lib/liblldb.so"
		),
	},
	server = {
		on_attach = function()
			vim.cmd([[au BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
		end,
	},
})
