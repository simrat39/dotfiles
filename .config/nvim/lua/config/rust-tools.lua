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
})
