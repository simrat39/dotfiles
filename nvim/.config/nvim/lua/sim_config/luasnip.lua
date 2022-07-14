local M = {}

local ls = require("luasnip")

ls.config.set_config({
  history = true,
  updateevents = "TextChanged, TextChangedI",
  enable_autosnippets = true,
})

function M.navigate(num)
  if ls.jumpable(num) then
    ls.jump(num)
  end
end

return M
