local awful = require("awful")

awful.spawn.with_shell("xset b off")
-- awful.spawn.with_shell("picom --experimental-backends &")
awful.spawn.with_shell("xset r rate 300 50")
awful.spawn.with_shell("killall plasmashell")
awful.spawn.with_shell("killall ksplashqml")
