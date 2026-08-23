---@meta
-------------------------------------------------------------------------------
-- OXWM Configuration File
-------------------------------------------------------------------------------
-- This is the default configuration for OXWM, a dynamic window manager.
-- Edit this file and reload with Mod+Shift+R (no compilation needed)
--
-- For more information about configuring OXWM, see the documentation.
-- The Lua Language Server provides autocomplete and type checking.
-------------------------------------------------------------------------------

---Load type definitions for LSP
---@module 'oxwm'

-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------
-- Define your variables here for easy customization throughout the config.
-- This makes it simple to change keybindings, colors, and settings in one place.

-- Modifier key: "Mod4" is the Super/Windows key, "Mod1" is Alt
local modkey = "Mod4"

-- Terminal emulator command (defaults to alacritty)
local terminal = "alacritty"

-- Color palette - customize these to match your theme
-- Alternatively you can import other files in here, such as
-- local colors = require("colors") and make colors.lua a file
-- in the ~/.config/oxwm directory

-- local colors = require("default")
local colors = require("synthwave")

-- Workspace tags - can be numbers, names, or icons (requires a Nerd Font)
-- The number of tags is deduced from the size of this table (up to a max of 12).
-- The default is 9. To use more, add entries here and uncomment the matching
-- keybinds for tags 10-12 further down in this file.
local tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
-- local tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" } -- Example of 12 tags
-- local tags = { "", "󰊯", "", "", "󰙯", "󱇤", "", "󱘶", "󰧮" } -- Example of nerd font icon tags

-- Font for the status bar (use "fc-list" to see available fonts)
local bar_font = "JetBrainsMono Nerd Font:style=Bold:size=12"

-- Define your blocks
-- Similar to widgets in qtile, or dwmblocks
local blocks = {
    oxwm.bar.block.shell({
        format = "Vol: {}",
    	command = "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{vol=int($2*100); if ($3==\"[MUTED]\") print \"\u{f0581} \"vol\"%\"; else print \"\u{f057e} \"vol\"%\"}'",
    	interval = 1,
    	color = colors.c3,
    	underline = false,
    }),
    oxwm.bar.block.static({
        text = "│",
        interval = 999999999,
        color = colors.c4,
        underline = false,
    }),
    oxwm.bar.block.ram({
        format = "Ram: {used}/{total} GB",
        interval = 10,
        color = colors.c5,
        underline = false,
    }),
    oxwm.bar.block.static({
        text = "│",
        interval = 999999999,
        color = colors.c4,
        underline = false,
    }),
    oxwm.bar.block.shell({
        format = "{}",
        command = "uname -r",
        interval = 999999999,
        color = colors.c1,
        underline = false,
    }),
    oxwm.bar.block.static({
        text = "│",
        interval = 999999999,
        color = colors.c4,
        underline = false,
    }),
    oxwm.bar.block.datetime({
        format = "{}",
        date_format = "%a, %b %d",
        interval = 1,
        color = colors.c2,
        underline = false,
    }),
    oxwm.bar.block.static({
        text = "│",
        interval = 999999999,
        color = colors.c4,
        underline = false,
    }),
    oxwm.bar.block.datetime({
        format = "{}",
        date_format = "%-I:%M %P",
        interval = 1,
        color = colors.c6,
        underline = false,
    }),
    oxwm.bar.block.static({
        text = "│",
        interval = 999999999,
        color = colors.c4,
        underline = false,
    }),
    -- Uncomment to add battery status (useful for laptops)
    oxwm.bar.block.battery({
        -- format = "{}",
        charging = "\u{f140b} Bat: {}%+",
        discharging = "\u{f007e} Bat: {}%-",
        full = "\u{f0079} Bat: {}%",
        interval = 1,
        color = colors.c3,
        underline = false,
        -- click: run a command when the block is clicked
        click = "alacritty -e btop",
        -- click = { command = "bluetui", floating = true },
    }),
};

-------------------------------------------------------------------------------
-- Basic Settings
-------------------------------------------------------------------------------
oxwm.set_terminal(terminal)
oxwm.set_modkey(modkey) -- This is for Mod + mouse binds, such as drag/resize
oxwm.set_tags(tags)

-- Set default layout (tiling by default)
-- oxwm.set_layout("tiling")

-------------------------------------------------------------------------------
-- Layouts
-------------------------------------------------------------------------------
-- Set custom symbols for layouts (displayed in the status bar)
-- Available layouts: "tiling", "normie" (floating), "grid", "monocle", "tabbed", "dwindle"
oxwm.set_layout_symbol("tiling", "[T]")
oxwm.set_layout_symbol("normie", "[F]")
oxwm.set_layout_symbol("tabbed", "[=]")
-- oxwm.set_layout_symbol("dwindle", "[\\]")

-- Example: bind dwindle (fibonacci) layout
-- oxwm.key.bind({ modkey }, "R", oxwm.layout.set("dwindle"))

-- Set default layout of specific tag (tag_index, layout_name)
-- Unset value uses oxwm.set_layout value
-- oxwm.set_tag_layout(1, "grid")

-------------------------------------------------------------------------------
-- Appearance
-------------------------------------------------------------------------------
-- Border configuration

-- Width in pixels
oxwm.border.set_width(0)
-- Color of focused window border
oxwm.border.set_focused_color(colors.c5)
-- Color of unfocused window borders
oxwm.border.set_unfocused_color(colors.grey)

-- Where floating windows spawn: "top-left", "top-center", "top-right",
-- "center-left", "center", "center-right", "bottom-left", "bottom-center", "bottom-right"
oxwm.set_floating_position("center")

-- Smart Enabled = No border if 1 window
oxwm.gaps.set_smart(true)
-- Inner gaps (horizontal, vertical) in pixels
oxwm.gaps.set_inner(2, 2)
-- Outer gaps (horizontal, vertical) in pixels
oxwm.gaps.set_outer(2, 2)

-------------------------------------------------------------------------------
-- Window Rules
-------------------------------------------------------------------------------
-- Rules allow you to automatically configure windows based on their properties
-- You can match windows by class, instance, title, or role
-- Available properties: floating, tag, fullscreen, etc.
--
-- Common use cases:
-- - Force floating for certain applications (dialogs, utilities)
-- - Send specific applications to specific workspaces
-- - Configure window behavior based on title or class

-- Examples (uncomment to use):
oxwm.rule.add({ instance = "gimp", floating = true })
oxwm.rule.add({ class = "tty-float", focus = true, floating = true })
oxwm.rule.add({ class = "firefox", title = "Library", floating = true })
-- oxwm.rule.add({ class = "firefox", tag = 2 })
-- oxwm.rule.add({ instance = "mpv", floating = true })

-- To find window properties, use xprop and click on the window
-- WM_CLASS(STRING) shows both instance and class (instance, class)

-------------------------------------------------------------------------------
-- Status Bar Configuration
-------------------------------------------------------------------------------
-- Font configuration
oxwm.bar.set_font(bar_font)

-- Position configuration (top/bottom, top is default)
-- oxwm.bar.set_position("bottom")

-- Set your blocks here (defined above)
oxwm.bar.set_blocks(blocks)

-- Bar color schemes (for workspace tag display)
-- Parameters: foreground, background, border

-- Unoccupied tags
oxwm.bar.set_scheme_normal(colors.grey, colors.bg, "#444444")
-- Occupied tags
oxwm.bar.set_scheme_occupied(colors.c2, colors.bg, colors.c2)
-- Currently selected tag
oxwm.bar.set_scheme_selected(colors.c1, colors.bg, colors.c1)
-- Urgent tags (windows requesting attention)
oxwm.bar.set_scheme_urgent(colors.c3, colors.bg, colors.c3)

-- Hide tags that have no windows and are not selected
-- oxwm.bar.set_hide_vacant_tags(true)

-------------------------------------------------------------------------------
-- Keybindings
-------------------------------------------------------------------------------
-- Keybindings are defined using oxwm.key.bind(modifiers, key, action)
-- Modifiers: {"Mod4"}, {"Mod1"}, {"Shift"}, {"Control"}, or combinations like {"Mod4", "Shift"}
-- Keys: Use uppercase for letters (e.g., "Return", "H", "J", "K", "L")
-- Actions: Functions that return actions (e.g., oxwm.spawn(), oxwm.client.kill())
--
-- A list of available keysyms can be found in the X11 keysym definitions.
-- Common keys: Return, Space, Tab, Escape, Backspace, Delete, Left, Right, Up, Down

-- System controls
oxwm.key.bind({ "Mod1" }, "R", oxwm.spawn({ "sh", "-c", "reboot" }))
oxwm.key.bind({ "Mod1" }, "S", oxwm.spawn({ "sh", "-c", "shutdown now" }))
oxwm.key.bind({ "Mod1" }, "L", oxwm.spawn({ "sh", "-c", "systemctl suspend" }))

-- Launch Dmenu
oxwm.key.bind({ modkey }, "D", oxwm.spawn({ "sh", "-c", "dmenu_run -l 15" }))
oxwm.key.bind({ modkey }, "Q", oxwm.client.kill())

-- Copy screenshot to clipboard
oxwm.key.bind({ modkey }, "S", oxwm.spawn({ "sh", "-c", "mkdir -p ~/Screenshots && FILE=~/Screenshots/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png &&  maim -s \"$FILE\" &&  xclip -selection clipboard -t image/png -i \"$FILE\"" }))

-- User Applications
oxwm.key.bind({ modkey }, "P", oxwm.spawn({ "pcmanfm" }))
oxwm.key.bind({ modkey }, "F", oxwm.spawn({ "firefox" }))
oxwm.key.bind({ modkey }, "Return", oxwm.spawn_terminal())
oxwm.key.bind({ modkey }, "T", oxwm.spawn({ "alacritty --class tty-float" }))
oxwm.key.bind({ modkey }, "W", oxwm.spawn({ "alacritty --class tty-float -e nmtui connect" }))

-- Volume Controls
oxwm.key.bind({}, "F3", oxwm.spawn({ "sh", "-c", "wpctl set-volume @DEFAULT_SINK@ 5%+" }))
oxwm.key.bind({}, "F2", oxwm.spawn({ "sh", "-c", "wpctl set-volume @DEFAULT_SINK@ 5%-" }))
oxwm.key.bind({}, "F1", oxwm.spawn({ "sh", "-c", "wpctl set-mute @DEFAULT_SINK@ toggle" }))

-- Brightness Controls
oxwm.key.bind({}, "F12", oxwm.spawn({ "sh", "-c", "brightnessctl set +10%" }))
oxwm.key.bind({}, "F11", oxwm.spawn({ "sh", "-c", "brightnessctl set 10%-" }))

-- Cycle Wallpapers
oxwm.key.bind({ modkey, "Shift" }, "W", oxwm.spawn({ "sh", "-c", "~/.config/wallpapers/next-wallpaper.sh" }))

-- Clipboard copyq
oxwm.key.bind({ modkey, "Shift" }, "V", oxwm.spawn({ "copyq toggle" }))

-- Keybind overlay - Shows important keybindings on screen
oxwm.key.bind({ modkey, "Shift" }, "Slash", oxwm.show_keybinds())

-- Window state toggles
oxwm.key.bind({ modkey, "Shift" }, "F", oxwm.client.toggle_fullscreen())
oxwm.key.bind({ modkey, }, "Space", oxwm.client.toggle_floating())

-- Layout management
oxwm.key.bind({ modkey, "Shift" }, "F", oxwm.layout.set("normie"))
oxwm.key.bind({ modkey, "Shift" }, "T", oxwm.layout.set("tiling"))
-- Cycle through layouts
oxwm.key.bind({ modkey, "Shift" }, "Space", oxwm.layout.cycle())

-- Master area controls (tiling layout)

-- Decrease/Increase master area width
oxwm.key.bind({ modkey }, "H", oxwm.set_master_factor(-5))
oxwm.key.bind({ modkey }, "L", oxwm.set_master_factor(5))
-- Enable tiled resize mode: Mod+RMB drag adjusts mfact instead of floating
-- oxwm.tiled_resize_mode(true)
-- Increment/Decrement number of master windows
oxwm.key.bind({ modkey, "Shift" }, "I", oxwm.inc_num_master(1))
oxwm.key.bind({ modkey, "Shift" }, "P", oxwm.inc_num_master(-1))

-- Gaps toggle
oxwm.key.bind({ modkey }, "A", oxwm.toggle_gaps())
-- Bar toggle
oxwm.key.bind({ modkey }, "B", oxwm.toggle_bar())

-- Window manager controls
oxwm.key.bind({ "Mod1" }, "Q", oxwm.quit())
oxwm.key.bind({ modkey, "Shift" }, "R", oxwm.restart())

-- Focus movement [1 for up in the stack, -1 for down]
oxwm.key.bind({ modkey }, "J", oxwm.client.focus_stack(1))
oxwm.key.bind({ modkey }, "K", oxwm.client.focus_stack(-1))

-- Window movement (swap position in stack)
oxwm.key.bind({ modkey, "Shift" }, "J", oxwm.client.move_stack(1))
oxwm.key.bind({ modkey, "Shift" }, "K", oxwm.client.move_stack(-1))

-- Multi-monitor support

-- Focus next/previous Monitors
oxwm.key.bind({ modkey }, "Comma", oxwm.monitor.focus(-1))
oxwm.key.bind({ modkey }, "Period", oxwm.monitor.focus(1))
-- Move window to next/previous Monitors
oxwm.key.bind({ modkey, "Shift" }, "Comma", oxwm.monitor.tag(-1))
oxwm.key.bind({ modkey, "Shift" }, "Period", oxwm.monitor.tag(1))

-- Warp the cursor to the focused monitor when switching monitors
-- oxwm.monitor.warp_cursor(true)
-- Warp the cursor along when sending a window to another monitor
-- oxwm.monitor.warp_cursor_on_send(true)

-- Workspace (tag) navigation
-- Switch to workspace N (tags are 0-indexed, so tag "1" is index 0)
oxwm.key.bind({ modkey }, "1", oxwm.tag.view(0))
oxwm.key.bind({ modkey }, "2", oxwm.tag.view(1))
oxwm.key.bind({ modkey }, "3", oxwm.tag.view(2))
oxwm.key.bind({ modkey }, "4", oxwm.tag.view(3))
oxwm.key.bind({ modkey }, "5", oxwm.tag.view(4))
oxwm.key.bind({ modkey }, "6", oxwm.tag.view(5))
oxwm.key.bind({ modkey }, "7", oxwm.tag.view(6))
oxwm.key.bind({ modkey }, "8", oxwm.tag.view(7))
oxwm.key.bind({ modkey }, "9", oxwm.tag.view(8))
-- Tags 10-12 (opt-in): set 12 tags above, then pick keys you like and uncomment.
-- oxwm.key.bind({ modkey }, "0", oxwm.tag.view(9))
-- oxwm.key.bind({ modkey }, "minus", oxwm.tag.view(10))
-- oxwm.key.bind({ modkey }, "equal", oxwm.tag.view(11))

-- Move focused window to workspace N
oxwm.key.bind({ modkey, "Shift" }, "1", oxwm.tag.move_to(0))
oxwm.key.bind({ modkey, "Shift" }, "2", oxwm.tag.move_to(1))
oxwm.key.bind({ modkey, "Shift" }, "3", oxwm.tag.move_to(2))
oxwm.key.bind({ modkey, "Shift" }, "4", oxwm.tag.move_to(3))
oxwm.key.bind({ modkey, "Shift" }, "5", oxwm.tag.move_to(4))
oxwm.key.bind({ modkey, "Shift" }, "6", oxwm.tag.move_to(5))
oxwm.key.bind({ modkey, "Shift" }, "7", oxwm.tag.move_to(6))
oxwm.key.bind({ modkey, "Shift" }, "8", oxwm.tag.move_to(7))
oxwm.key.bind({ modkey, "Shift" }, "9", oxwm.tag.move_to(8))
-- oxwm.key.bind({ modkey, "Shift" }, "0", oxwm.tag.move_to(9))
-- oxwm.key.bind({ modkey, "Shift" }, "minus", oxwm.tag.move_to(10))
-- oxwm.key.bind({ modkey, "Shift" }, "equal", oxwm.tag.move_to(11))

-- Combo view (view multiple tags at once) {argos_nothing}
-- Example: Mod+Ctrl+2 while on tag 1 will show BOTH tags 1 and 2
oxwm.key.bind({ modkey, "Control" }, "1", oxwm.tag.toggleview(0))
oxwm.key.bind({ modkey, "Control" }, "2", oxwm.tag.toggleview(1))
oxwm.key.bind({ modkey, "Control" }, "3", oxwm.tag.toggleview(2))
oxwm.key.bind({ modkey, "Control" }, "4", oxwm.tag.toggleview(3))
oxwm.key.bind({ modkey, "Control" }, "5", oxwm.tag.toggleview(4))
oxwm.key.bind({ modkey, "Control" }, "6", oxwm.tag.toggleview(5))
oxwm.key.bind({ modkey, "Control" }, "7", oxwm.tag.toggleview(6))
oxwm.key.bind({ modkey, "Control" }, "8", oxwm.tag.toggleview(7))
oxwm.key.bind({ modkey, "Control" }, "9", oxwm.tag.toggleview(8))
-- oxwm.key.bind({ modkey, "Control" }, "0", oxwm.tag.toggleview(9))
-- oxwm.key.bind({ modkey, "Control" }, "minus", oxwm.tag.toggleview(10))
-- oxwm.key.bind({ modkey, "Control" }, "equal", oxwm.tag.toggleview(11))

-- Multi tag (window on multiple tags)
-- Example: Mod+Ctrl+Shift+2 puts focused window on BOTH current tag and tag 2
oxwm.key.bind({ modkey, "Control", "Shift" }, "1", oxwm.tag.toggletag(0))
oxwm.key.bind({ modkey, "Control", "Shift" }, "2", oxwm.tag.toggletag(1))
oxwm.key.bind({ modkey, "Control", "Shift" }, "3", oxwm.tag.toggletag(2))
oxwm.key.bind({ modkey, "Control", "Shift" }, "4", oxwm.tag.toggletag(3))
oxwm.key.bind({ modkey, "Control", "Shift" }, "5", oxwm.tag.toggletag(4))
oxwm.key.bind({ modkey, "Control", "Shift" }, "6", oxwm.tag.toggletag(5))
oxwm.key.bind({ modkey, "Control", "Shift" }, "7", oxwm.tag.toggletag(6))
oxwm.key.bind({ modkey, "Control", "Shift" }, "8", oxwm.tag.toggletag(7))
oxwm.key.bind({ modkey, "Control", "Shift" }, "9", oxwm.tag.toggletag(8))
-- oxwm.key.bind({ modkey, "Control", "Shift" }, "0", oxwm.tag.toggletag(9))
-- oxwm.key.bind({ modkey, "Control", "Shift" }, "minus", oxwm.tag.toggletag(10))
-- oxwm.key.bind({ modkey, "Control", "Shift" }, "equal", oxwm.tag.toggletag(11))

-------------------------------------------------------------------------------
-- Advanced: Keychords
-------------------------------------------------------------------------------
-- Keychords allow you to bind multiple-key sequences (like Emacs or Vim)
-- Format: {{modifiers}, key1}, {{modifiers}, key2}, ...
-- Example: Press Mod4+Space, then release and press T to spawn a terminal
oxwm.key.chord({
    { { modkey }, "Space" },
    { {},         "T" }
}, oxwm.spawn_terminal())

-------------------------------------------------------------------------------
-- Autostart
-------------------------------------------------------------------------------
-- Commands to run once when OXWM starts
-- Uncomment and modify these examples, or add your own

oxwm.autostart("~/.config/wallpapers/init-wallpaper.sh")
oxwm.autostart("~/.config/init-lock.sh")
oxwm.autostart("copyq")
oxwm.autostart("lxqt-policykit-agent")
oxwm.autostart("pcmanfm --daemon-mode")
oxwm.autostart("picom")
oxwm.autostart("libinput-gestures-setup start")
-- oxwm.autostart("gestures-setup start")
