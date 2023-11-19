local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local setup_auto_format = require("utils.lsp").setup_auto_format

setup_auto_format("dart")
setup_auto_format("rs")

setup_auto_format("cpp")
setup_auto_format("cc")
setup_auto_format("c")
setup_auto_format("h")

setup_auto_format("js", "FormatWrite")
setup_auto_format("css", "FormatWrite")
setup_auto_format("html", "FormatWrite")

setup_auto_format("jsx")
setup_auto_format("tsx")
setup_auto_format("svelte")
setup_auto_format("ts")
setup_auto_format("py")
setup_auto_format("dart")
setup_auto_format("lua", "lua require('stylua-nvim').format_file()")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
-----------------------
-- Random others
-----------------------
require("lspconfig").asm_lsp.setup({
  capabilities = capabilities,
})

lspconfig.clangd.setup({
  cmd = {
    -- see clangd --help-hidden
    "clangd",
    "--background-index",
    -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
    -- to add more checks, create .clang-tidy file in the root directory
    -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
    "--clang-tidy",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--header-insertion=iwyu",
  },
  init_options = {
    clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  capabilities = capabilities,
  on_attach = function(c, b)
    -- ih.on_attach(c, b)
  end,
})

lspconfig.pylsp.setup({ capabilities = capabilities })

require("lspconfig").pyright.setup({
  capabilities = capabilities,
})
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
require("neodev").setup()
require("lspconfig").sumneko_lua.setup({
  capabilities = capabilities,
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      hint = {
        enable = true,
      },
    },
  },
})

require("lspconfig").gopls.setup({
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

if not configs.ls_emmet then
  configs.ls_emmet = {
    default_config = {
      cmd = { "ls_emmet", "--stdio" },
      filetypes = {
        "html",
        "css",
        "scss",
        "javascriptreact",
        "typescriptreact",
        "haml",
        "xml",
        "xsl",
        "pug",
        "slim",
        "sass",
        "stylus",
        "less",
        "sss",
        "hbs",
        "handlebars",
      },
      root_dir = function()
        return vim.loop.cwd()
      end,
      settings = {},
    },
  }
end

lspconfig.ls_emmet.setup({ capabilities = capabilities })

lspconfig.sqlls.setup({ capabilities = capabilities })
