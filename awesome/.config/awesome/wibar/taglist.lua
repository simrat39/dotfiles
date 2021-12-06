local keymaps = require("keymaps")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local font = require("utils/font")

local client = client

local M = { widget = nil }

local function get_buttons()
  -- Create a wibox for each screen and add it
  return gears.table.join(
    -- left click, move to tag
    awful.button({}, 1, function(t)
      t:view_only()
    end),

    -- mod + left click, move current window to tag
    awful.button({ keymaps.modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end),

    -- right click, hide / view tag contents
    awful.button({}, 3, awful.tag.viewtoggle),

    -- idk
    awful.button({ keymaps.modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end),

    -- scroll
    awful.button({}, 4, function(t)
      awful.tag.viewnext(t.screen)
    end),

    -- scroll
    awful.button({}, 5, function(t)
      awful.tag.viewprev(t.screen)
    end)
  )
end

function M.get(s)
  return awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.noempty,
    buttons = get_buttons(),
    layout = {
      spacing = 4,
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        {
          id = "text_role",
          text = "0",
          widget = wibox.widget.textbox,
        },
        margins = {
          left = 10,
          right = 10,
        },
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
    },
  })
end

return M
