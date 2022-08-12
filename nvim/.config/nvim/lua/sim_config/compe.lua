local cmp = require("cmp")

local compare = require("cmp.config.compare")

---whateva
---@param a number
---@return number
local function bruh(a)
  return a + 10
end

local a = bruh(20)

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    -- ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-b>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(cmp.SelectBehavior.Insert),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp.SelectBehavior.Insert),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "emoji" },
    { name = "buffer" },
    { name = "nvim_lsp_signature_help" },
  },
})
