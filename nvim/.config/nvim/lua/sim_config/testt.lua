local compare = require("cmp.config.compare")

---whateva
---@param a number
---@param b string
---@param c number
---@return number
local function bruh(a, b, c)
  return a + 10
end

local a = bruh(10, "", 20)
print(a)
