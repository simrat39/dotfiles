-----------------------
-- Rust
-----------------------
require'rust-tools'.setup({
    server = {settings = {["rust-analyzer"] = {checkOnSave = {enable = true}}}}
})
-- require'lspconfig'.rust_analyzer.setup {
--     on_attach = function(arg1, arg2)
--         print("on attach called")
--         print(arg1)
--         print(arg2)
--     end
-- }
