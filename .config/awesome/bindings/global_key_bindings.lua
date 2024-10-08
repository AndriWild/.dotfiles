local gears         = require("gears")
local awful         = require("awful")
local beautiful     = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local constants     = require("constants")

local xrandr = require("xrandr")
local modkey = constants.modkey

-- {{{ Key bindings
globalkeys = gears.table.join(
        awful.key(
                { modkey },
                "s",
                hotkeys_popup.show_help,
                { description = "show help", group = "awesome" }
        ),
        awful.key(
                { modkey },
                "Escape",
                awful.tag.history.restore,
                { description = "go back", group = "tag" }
        ),
        awful.key(
                { "Control", "Mod1" },
                "Delete",
                function()
                    awful.spawn.with_shell("i3lock -c 000000 -f && systemctl suspend")
                end,
                { description = "suspend", group = "power" }
        ),
        awful.key(
                { "Control", "Mod1" },
                "End",
                function()
                    awful.spawn.with_shell("shutdown now")
                end,
                { description = "shutdown", group = "power" }
        ),
        awful.key(
                { modkey },
                "j",
                function ()
                    awful.client.focus.byidx( 1)
                end,
                { description = "focus next by index", group = "client" }
        ),
		awful.key(
				{ modkey },
				"Left",
				function()
						awful.layout.inc(-1)
				end,
				{ description = "previous layout modi", group = "layout " }
		),
		awful.key(
				{modkey },
				"Right",
				function()
						awful.layout.inc(1)
				end,
				{ description = "next layout modi", group = "layout " }
		),
        awful.key(
                { modkey },
                "k",
                function ()
                    awful.client.focus.byidx(-1)
                end,
                { description = "focus previous by index", group = "client" }
        ),
        awful.key(
                { modkey },
                "w",
                function ()
                    awful.spawn.with_shell( "bash ~/.config/rofi-network-manager/rofi-network-manager.sh")
                end,
                { description = "show wlan menu", group = "launcher" }
        ),
        awful.key(
                { modkey, "Shift"   },
                "w",
                function ()
                    awful.spawn.with_shell( "bash ~/.config/rofi-bluetooth/rofi-bluetooth")
                end,
                { description = "show bluetooth menu", group = "launcher" }
        ),
        awful.key(
                { modkey, "Mod1" },
                "space",
                function ()
                    awful.util.spawn("rofi -show fhnw -modi fhnw:~/.config/rofi/open_folder.sh")
                end,
                { description = "show fhnw folders", group = "launcher" }
        ),

-- Layout manipulation
        awful.key(
                { modkey, "Shift" },
                "j",
                function ()
                    awful.client.swap.byidx(  1)
                end,
                {description = "swap with next client by index", group = "client"}
        ),
        awful.key(
                { modkey, "Shift" },
                "k",
                function ()
                    awful.client.swap.byidx( -1)
                end,
                {description = "swap with previous client by index", group = "client"}
        ),
        awful.key(
                { modkey, "Control" },
                "j",
                function ()
                    awful.screen.focus_relative( 1)
                end,
                { description = "focus the next screen", group = "screen" }
        ),
        awful.key(
                { modkey, "Control" },
                "k",
                function ()
                    awful.screen.focus_relative(-1)
                end,
                { description = "focus the previous screen", group = "screen" }
        ),
        awful.key(
                { modkey },
                "u",
                awful.client.urgent.jumpto,
                { description = "jump to urgent client", group = "client" }
        ),
        awful.key(
                { modkey },
                "Tab",
                function ()
                    awful.client.focus.history.previous()
                    if client.focus then
                        client.focus:raise()
                    end
                end,
                { description = "go back", group = "client" }
        ),

-- Standard program
        awful.key(
                { modkey },
                "Return",
                function ()
                    awful.spawn(constants.terminal, {
                        tag = beautiful.tagIcons[3]
                    })
                end,
                { description = "open a terminal", group = "launcher" }
        ),
        awful.key(
                { modkey, "Control" },
                "r",
                awesome.restart,
                { description = "reload awesome", group = "awesome" }
        ),
        awful.key(
                { modkey, "Shift" },
                "q",
                awesome.quit,
                { description = "quit awesome", group = "awesome" }
        ),
        awful.key(
                { modkey },
                "l",
                function ()
                    awful.tag.incmwfact( 0.05)
                end,
                { description = "increase master width factor", group = "layout" }
        ),
        awful.key(
                { modkey },
                "h",
                function ()
                    awful.tag.incmwfact(-0.05)
                end,
                { description = "decrease master width factor", group = "layout" }
        ),
        awful.key(
                { modkey, "Shift" },
                "h",
                function ()
                    awful.tag.incnmaster( 1, nil, true)
                end,
                { description = "increase the number of master clients", group = "layout" }
        ),
        awful.key(
                { modkey, "Shift" },
                "l",
                function ()
                    awful.tag.incnmaster(-1, nil, true)
                end,
                { description = "decrease the number of master clients", group = "layout" }
        ),
        awful.key(
                { modkey, "Control" },
                "h",
                function ()
                    awful.tag.incncol( 1, nil, true)
                end,
                { description = "increase the number of columns", group = "layout" }
        ),
        awful.key(
                { modkey, "Control" },
                "l",
                function ()
                    awful.tag.incncol(-1, nil, true)
                end,
                { description = "decrease the number of columns", group = "layout" }
        ),
        awful.key(
                { modkey, "Control" },
                "s",
                function ()
                    awful.layout.inc( 1)
                end,
                { description = "select next", group = "layout" }
        ),
        awful.key(
                { modkey, "Shift" },
                "s",
                function ()
                    awful.layout.inc(-1)
                end,
                { description = "select previous", group = "layout" }
        ),
        awful.key(
                { modkey, "Control" },
                "n",
                function ()
                    local c = awful.client.restore()
                    -- Focus restored client
                    if c then
                        c:emit_signal(
                                "request::activate", "key.unminimize", {raise = true}
                        )
                    end
                end,
                { description = "restore minimized", group = "client" }
        ),
-- Prompt
        awful.key(
                { modkey },
                "r",
                function ()
                    awful.screen.focused().mypromptbox:run()
                end,
                { description = "run prompt", group = "launcher" }
        ),
        awful.key(
                { modkey },
                "p",
				function()
						 xrandr.xrandr()
				end,
                { description = "lua execute prompt", group = "awesome" }
				),
        awful.key(
                { "Mod1" },
                "p",
				function()
						awful.util.spawn("flameshot gui")
				end,
                { description = "Screenshot", group = "launcher" }
				),
-- Menubar
        awful.key(
                { modkey },
                "space",
                function()
                    awful.util.spawn("rofi -show drun")
                end,
                { description = "show the menubar", group = "launcher" }
        )
)
