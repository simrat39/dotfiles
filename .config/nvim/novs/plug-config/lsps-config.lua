local vim = vim

-- enable snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local nvim_lsp = require'lspconfig'

-----------------------
-- Dart / Flutter
-----------------------
local function setupFlutterTools()
    require("flutter-tools").setup{} --use defaults
end

pcall(setupFlutterTools)

-----------------------
-- lua
-----------------------
nvim_lsp.sumneko_lua.setup{
    cmd = {"lua-language-server"};
    capabilities = capabilities;
}

-----------------------
-- Rust
-----------------------
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
}

capabilities.experimental = {}
capabilities.experimental.hoverActions = true

nvim_lsp.rust_analyzer.setup({
    capabilities = capabilities,
})

local function setup_rust_tools()
    require'rust-tools'.setup({
        autoSetHints = true,
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            show_parameter_hints = true,
        },
    })
    require'rust-tools-debug'.setup()
end

pcall(setup_rust_tools)

-----------------------
-- other random stuff
-----------------------
vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
