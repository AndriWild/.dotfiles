-- ALSA volume
-- local icon_vol_muted	= gears.filesystem.get_configuration_dir() .. "themes/icons/audio-volume-muted-symbolic.svg"
-- local icon_vol_low		= gears.filesystem.get_configuration_dir() .. "themes/icons/audio-volume-low-symbolic.svg"
-- local icon_vol_medium	= gears.filesystem.get_configuration_dir() .. "themes/icons/audio-volume-medium-symbolic.svg"
-- local icon_vol_high		= gears.filesystem.get_configuration_dir() .. "themes/icons/audio-volume-high-symbolic.svg"

-- local volume_icon= wibox.widget.imagebox(icon_vol_high)
-- local volume = lain.widget.alsa({
-- 		cmd = "amixer -c 1",
--     settings = function()
--         if volume_now.status == "off" then
--             volume_icon:set_image(icon_vol_muted)
--         elseif tonumber(volume_now.level) <= 25 then
--             volume_icon:set_image(icon_vol_low)
--         elseif tonumber(volume_now.level) >= 50 then
--             volume_icon:set_image(icon_vol_medium)
--         else
--             volume_icon:set_image(icon_vol_high)
--         end
--     end
-- })

-- local volume_widget = wibox.container.margin(wibox.widget{ volume_icon, volume.widget, layout = wibox.layout.align.horizontal }, 2,2,3,3)
--
-- volume_widget:buttons(awful.util.table.join(
--     awful.button({}, 1, function() -- left click
-- 			log("klick")
--         awful.spawn(string.format("%s -e alsamixer", terminal))
--     end),
--     awful.button({}, 2, function() -- middle click
--         os.execute(string.format("%s set %s 100%%", volume.cmd, volume.channel))
--         volume.update()
--     end),
--     awful.button({}, 3, function() -- right click
--         os.execute(string.format("%s set %s toggle", volume.cmd, volume.togglechannel or volume.channel))
--         volume.update()
--     end),
--     awful.button({}, 4, function() -- scroll up
--         os.execute(string.format("%s set %s 1%%+", volume.cmd, volume.channel))
--         volume.update()
--     end),
--     awful.button({}, 5, function() -- scroll down
--         os.execute(string.format("%s set %s 1%%-", volume.cmd, volume.channel))
--         volume.update()
--     end)
-- ))