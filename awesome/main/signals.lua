-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Custom Local Library: Common Functional Decoration
--require("deco.titlebar")

-- reading
-- https://awesomewm.org/apidoc/classes/signals.html

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- set new windows as slaves
    if not awesome.startup then
        awful.client.setslave(c)
    end

    -- keep them on screen after restarts
    if awesome.startup
       and not c.size_hints.user_position
       and not c.size_hints.program_position
    then
        awful.placement.no_offscreen(c)
    end

    -- clip to an 8px rounded rectangle
    --c.shape = function(cr, w, h)
    --    gears.shape.rounded_rect(cr, w, h, 8)
    --end

    -- draw a rounded border, width pulled from your theme
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
