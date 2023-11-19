-----------------------
-- Rust
-----------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local rt = require("rust-tools")

local extension_path = vim.env.HOME
  .. "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

rt.setup({
  tools = {
    hover_actions = {
      auto_focus = true,
    },

    inlay_hints = {
      auto = true,
      max_len_align = true,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 5,
    },
    on_initialized = function()
      -- ih.set_all()
    end,
  },
  server = {
    on_attach = function(client, bufnr)
      -- ih.on_attach(client, bufnr)
      vim.keymap.set(
        "n",
        "<C-space>",
        rt.hover_actions.hover_actions,
        { buffer = bufnr }
      )

      vim.keymap.set(
        "n",
        "<Leader>a",
        rt.code_action_group.code_action_group,
        { buffer = bufnr }
      )
    end,
    settings = {
      ["rust-analyzer"] = {
    completion = {
        snippets = {
            custom = {
                ["thread spawn"] = {
                    prefix = { "spawn", "tspawn" },
                    body = { "thread::spawn(move || {", "	$0", "});" },
                    description = "Insert a thread::spawn call",
                    requires = "std::thread",
                    scope = "expr"
                }
            },
        },
    },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
  dap = {
    adapter = false,
    -- adapter = require("rust-tools.dap").get_codelldb_adapter(
    --   codelldb_path,
    --   liblldb_path
    -- ),
  },
})

local dap = require("dap")
dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
