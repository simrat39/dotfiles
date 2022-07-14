local lspconfig = require("lspconfig")
local setup_auto_format = require("utils.lsp").setup_auto_format

setup_auto_format("dart")
setup_auto_format("rs")

setup_auto_format("cpp")
setup_auto_format("cc")
setup_auto_format("h")

setup_auto_format("js", "FormatWrite")
setup_auto_format("css", "FormatWrite")
setup_auto_format("html", "FormatWrite")

setup_auto_format("tsx")
setup_auto_format("svelte")
setup_auto_format("ts")
setup_auto_format("py")
setup_auto_format("dart")
setup_auto_format("lua", "lua require('stylua-nvim').format_file()")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-----------------------
-- Webdev
-----------------------
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({
  capabilities = capabilities,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
      end,
    },
  },
})
lspconfig.html.setup({
  capabilities = capabilities,
})
lspconfig.tailwindcss.setup({ capabilities = capabilities })
lspconfig.svelte.setup({ capabilities = capabilities })
lspconfig.emmet_ls.setup({ capabilities = capabilities })
-----------------------
-- Random others
-----------------------
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.pylsp.setup({ capabilities = capabilities })
require("lspconfig").pyright.setup({ capabilities = capabilities })
require("lspconfig").yamlls.setup({
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/pubspec.json"] = "pubspec.yaml",
      },
    },
  },
})
-----------------------
-- Lua
-----------------------
local luadev = require("lua-dev").setup({
  lspconfig = {
    capabilities = capabilities,
    cmd = { "lua-language-server" },
  },
  settings = {
    Lua = {
      workspace = {
        library = {
          ["/usr/share/nvim/runtime/lua"] = true,
          ["/usr/share/nvim/runtime/lua/lsp"] = true,
          ["/usr/share/awesome/lib"] = true,
        },
      },
    },
  },
})
require("lspconfig").sumneko_lua.setup(luadev)
