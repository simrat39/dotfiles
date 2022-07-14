-----------------------
-- Rust
-----------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require("rust-tools").setup({
  tools = {
    hover_actions = {
      border = "double",
    },
    inlay_hints = {
      auto = true,
      only_current_line = false,
    },
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(
      "/home/simrat39/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/adapter/codelldb",
      "/home/simrat39/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/lldb/lib/liblldb.so"
    ),
  },
  server = {
      capabilities = capabilities,
  }
})
