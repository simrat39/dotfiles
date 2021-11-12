local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local keymaps = require("keymaps")
local fs = require("utils/fs")
local battery_service = require("services/battery")

local client = client
local awesome = awesome

local M = {}

local function padded_rounded_rectangular_widget(widget, fg_color)
  local padding_widget = wibox.container.margin(
    widget,
    beautiful.wibar_generic_item_padding_horizontal,
    beautiful.wibar_generic_item_padding_horizontal,
    beautiful.wibar_generic_item_padding_vertical,
    beautiful.wibar_generic_item_padding_vertical,
    nil,
    true
  )

  local ret = wibox.container.background(
    padding_widget,
    beautiful.bg_focus,
    gears.shape.rounded_rect
  )

  ret.fg = fg_color
  return ret
end

local spacer_widget = wibox.container.margin(
  nil,
  beautiful.wibar_generic_spacing_horizontal,
  beautiful.wibar_generic_spacing_horizontal,
  nil,
  nil,
  nil,
  true
)

-- Create a textclock widget
local my_date_widget = padded_rounded_rectangular_widget(
  wibox.widget.textclock("%a %b %d"),
  beautiful.dracula.green
)

local my_time_widget = padded_rounded_rectangular_widget(
  wibox.widget.textclock("%I:%M %p"),
  beautiful.dracula.orange
)

local volume_text_widget = wibox.widget.textbox(" ")
awesome.connect_signal("sim::volume", function(data)
  volume_text_widget:set_markup_silently(" " .. data)
end)

local stylesheet = "" .. "svg { fill:" .. beautiful.dracula.pink .. "; } "

local vw = wibox.widget({
  layout = wibox.layout.fixed.horizontal,
  {
    {
      widget = wibox.widget.imagebox,
      stylesheet = stylesheet,
      image = fs.icon("speaker_full"),
    },
    margins = 3,
    layout = wibox.container.margin,
  },
  volume_text_widget,
})
local volume_widget = padded_rounded_rectangular_widget(
  vw,
  beautiful.dracula.pink
)

local battery_text_widget = wibox.widget.textbox("  ")
awesome.connect_signal("sim::battery", function(data)
  local markup = "  " .. data.percentage .. "%"

  if data.state == battery_service.DeviceState.CHARGING then
    markup = markup .. "  "
  end

  battery_text_widget:set_markup_silently(markup)
end)

battery_service.emit_current_status(battery_service.get_device())

local stylesheet = "" .. "svg { fill:" .. beautiful.dracula.yellow .. "; } "

local bw = wibox.widget({
  layout = wibox.layout.fixed.horizontal,
  {
    widget = wibox.widget.imagebox,
    stylesheet = stylesheet,
    image = fs.icon("battery_full"),
  },
  battery_text_widget,
})
local battery_widget = padded_rounded_rectangular_widget(
  bw,
  beautiful.dracula.yellow
)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ keymaps.modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ keymaps.modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", { raise = true })
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

function M.wibar(s)
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.noempty,
    buttons = taglist_buttons,
    layout = {
      spacing = 4,
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        {
          id = "text_role",
          visible = true,
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

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
    layout = {
      spacing = 4,
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        awful.widget.clienticon,
        margins = {
          left = 8,
          right = 8,
          top = 4,
          bottom = 4,
        },
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
    },
  })

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
  })

  -- Add widgets to the wibox
  s.mywibox:setup({
    {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.mytaglist,
      },
      {
        layout = wibox.container.place,
        valign = "center",
        halign = "center",
        s.mytasklist, -- Middle widget
      },
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        padded_rounded_rectangular_widget(wibox.widget.systray()),
        spacer_widget,
        battery_widget,
        spacer_widget,
        volume_widget,
        spacer_widget,
        my_date_widget,
        spacer_widget,
        my_time_widget,
        spacer_widget,
      },
    },
    margins = beautiful.wibar_padding,
    widget = wibox.container.margin,
  })
end

return M
