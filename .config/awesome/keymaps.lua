local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local terminal = "kitty"
local awful = require("awful")

---@diagnostic disable-next-line: undefined-global
local client = client
---@diagnostic disable-next-line: undefined-global
local awesome = awesome
---@diagnostic disable-next-line: undefined-global
local root = root

local M = {}

-- Default modkey.
M.modkey = "Mod4"

function M.setup_global_keymaps()
  local keys = gears.table.join(
    awful.key(
      { M.modkey },
      "s",
      hotkeys_popup.show_help,
      { description = "show help", group = "awesome" }
    ),

    awful.key(
      { M.modkey },
      "Left",
      awful.tag.viewprev,
      { description = "view previous", group = "tag" }
    ),

    awful.key(
      { M.modkey },
      "Right",
      awful.tag.viewnext,
      { description = "view next", group = "tag" }
    ),

    awful.key(
      { M.modkey },
      "Escape",
      awful.tag.history.restore,
      { description = "go back", group = "tag" }
    ),

    awful.key({ M.modkey }, "h", function()
      awful.client.focus.bydirection("left")
    end, {
      description = "focus client to the left",
      group = "client",
    }),

    awful.key({ M.modkey }, "l", function()
      awful.client.focus.bydirection("right")
    end, {
      description = "focus client to the right",
      group = "client",
    }),

    awful.key({ M.modkey }, "j", function()
      awful.client.focus.bydirection("down")
    end, {
      description = "focus client to the down",
      group = "client",
    }),

    awful.key({ M.modkey }, "k", function()
      awful.client.focus.bydirection("up")
    end, {
      description = "focus client to the up",
      group = "client",
    }),

    awful.key({ M.modkey }, "d", function()
      awful.spawn.with_shell(
        "rofi -show combi -combi-modi 'window,drun' -config ~/.config/rofi/default2.rasi"
      )
    end, {
      description = "open rofi",
      group = "launcher",
    }),

    -- Layout manipulation
    awful.key({ M.modkey, "Shift" }, "j", function()
      awful.client.swap.byidx(1)
    end, {
      description = "swap with next client by index",
      group = "client",
    }),

    awful.key({ M.modkey, "Shift" }, "k", function()
      awful.client.swap.byidx(-1)
    end, {
      description = "swap with previous client by index",
      group = "client",
    }),

    awful.key(
      { M.modkey },
      "u",
      awful.client.urgent.jumpto,
      { description = "jump to urgent client", group = "client" }
    ),

    -- Standard program
    awful.key({ M.modkey }, "Return", function()
      awful.spawn(terminal)
    end, {
      description = "open a terminal",
      group = "launcher",
    }),

    awful.key({ M.modkey, "Control" }, "r", function()
      awesome.emit_signal("sim::pre_restart")
      awesome.restart()
    end, {
      description = "reload awesome",
      group = "awesome",
    }),

    awful.key(
      { M.modkey, "Shift" },
      "c",
      awesome.quit,
      { description = "quit awesome", group = "awesome" }
    ),

    awful.key({ M.modkey, "Control" }, "n", function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
      end
    end, {
      description = "restore minimized",
      group = "client",
    }),

    awful.key({}, "XF86AudioMute", function()
      awful.spawn.easy_async("pactl set-sink-mute 0 toggle", function() end)
    end),

    awful.key({}, "XF86AudioRaiseVolume", function()
      awful.spawn.easy_async("pactl -- set-sink-volume 0 +2%", function() end)
    end),

    awful.key({}, "XF86AudioLowerVolume", function()
      awful.spawn.easy_async("pactl -- set-sink-volume 0 -2%", function() end)
    end)
  )

  local tags = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
  -- Bind all key numbers to tags.
  -- Be careful: we use keycodes to make it work on any keyboard layout.
  -- This should map on the top row of your keyboard, usually 1 to 9.
  for _, i in ipairs(tags) do
    keys = gears.table.join(
      keys,

      -- View tag only.
      awful.key({ M.modkey }, "#" .. i + 9, function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end, {
        description = "view tag #" .. i,
        group = "tag",
      }),

      -- Toggle tag display.
      awful.key({ M.modkey, "Control" }, "#" .. i + 9, function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end, {
        description = "toggle tag #" .. i,
        group = "tag",
      }),

      -- Move client to tag.
      awful.key({ M.modkey, "Shift" }, "#" .. i + 9, function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end, {
        description = "move focused client to tag #" .. i,
        group = "tag",
      }),

      -- Toggle tag on focused client.
      awful.key({ M.modkey, "Control", "Shift" }, "#" .. i + 9, function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end, {
        description = "toggle focused client on tag #" .. i,
        group = "tag",
      })
    )
  end

  root.keys(keys)
end

M.clientkeys = gears.table.join(
  awful.key({ M.modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, {
    description = "toggle fullscreen",
    group = "client",
  }),

  awful.key({ M.modkey, "Shift" }, "q", function(c)
    c:kill()
  end, {
    description = "close",
    group = "client",
  }),

  awful.key(
    { M.modkey, "Control" },
    "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),

  awful.key({ M.modkey, "Control" }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end, {
    description = "move to master",
    group = "client",
  }),

  awful.key({ M.modkey }, "o", function(c)
    c:move_to_screen()
  end, {
    description = "move to screen",
    group = "client",
  }),

  awful.key({ M.modkey }, "t", function(c)
    c.ontop = not c.ontop
  end, {
    description = "toggle keep on top",
    group = "client",
  }),

  awful.key({ M.modkey }, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end, {
    description = "minimize",
    group = "client",
  }),

  awful.key({ M.modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, {
    description = "(un)maximize",
    group = "client",
  }),

  awful.key({ M.modkey, "Control" }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end, {
    description = "(un)maximize vertically",
    group = "client",
  }),

  awful.key({ M.modkey, "Shift" }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end, {
    description = "(un)maximize horizontally",
    group = "client",
  })
)

return M
