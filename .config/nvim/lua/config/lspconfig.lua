local lspconfig = require("lspconfig")
local setup_auto_format = require("utils.lsp").setup_auto_format

setup_auto_format("dart")
setup_auto_format("rs")

setup_auto_format("cpp")
setup_auto_format("cc")
setup_auto_format("h")

setup_auto_format("js")
setup_auto_format("css")
setup_auto_format("tsx")
setup_auto_format("svelte")
setup_auto_format("ts")
setup_auto_format("py")
setup_auto_format("dart")
setup_auto_format("lua", "lua require('stylua-nvim').format_file()")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("desktop-notify").override_vim_notify()

-----------------------
-- Webdev
-----------------------
require("null-ls").config({})
require("lspconfig")["null-ls"].setup({})
lspconfig.tsserver.setup({
	cmd = { "typescript-language-server", "--stdio" },
	capabilities = capabilities,
	init_options = require("nvim-lsp-ts-utils").init_options,
	on_attach = function(client)
		-- disable tsserver formatting if you plan on formatting via null-ls
		client.resolved_capabilities.document_formatting = false

		local ts_utils = require("nvim-lsp-ts-utils")

		-- defaults
		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = false,

			-- import all
			import_all_timeout = 5000, -- ms
			import_all_priorities = {
				buffers = 4, -- loaded buffer names
				buffer_content = 3, -- loaded buffer content
				local_files = 2, -- git files or files with relative path markers
				same_file = 1, -- add to existing import statement
			},
			import_all_scan_buffers = 100,
			import_all_select_source = false,

			-- eslint
			eslint_enable_code_actions = true,
			eslint_enable_disable_comments = true,
			eslint_bin = "eslint_d",
			eslint_config_fallback = nil,
			eslint_enable_diagnostics = false,
			eslint_show_rule_id = false,

			-- formatting
			enable_formatting = true,
			formatter = "prettier",
			formatter_config_fallback = nil,

			-- update imports on file move
			update_imports_on_move = true,
			require_confirmation_on_move = true,
			watch_dir = nil,
		})

		-- required to fix code action ranges
		ts_utils.setup_client(client)
	end,
})
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
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.tailwindcss.setup({})
lspconfig.svelte.setup({ capabilities = capabilities })

lspconfig.clangd.setup({})
-- lspconfig.pylsp.setup({})

-----------------------
-- Lua
-----------------------
local luadev = require("lua-dev").setup({
	lspconfig = {
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

vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
