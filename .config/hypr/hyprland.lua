-- ~/.config/hypr/hyprland.lua
-- Hyprland 0.55+ Lua configuration
-- https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "1920x1080",
    position = "auto",
    scale    = "1",
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "alacritty"
local fileManager = "yazi"
local menu        = "dmenu_run"
local browser     = "firefox"

-------------------
---- AUTOSTART ----
-------------------
-- exec-once no longer exists; hook into the startup event instead

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- Note: Hyprland's docs now recommend putting session-wide env vars in
-- ~/.config/uwsm/env and ~/.config/uwsm/env-hyprland instead (if you use uwsm).
-- hl.env still works for Hyprland-only vars:

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 8,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(89b4faee)", "rgba(cba6f7ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },
    decoration = {
        rounding = 8,
        active_opacity   = 1.0,
        inactive_opacity = 0.9,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },
        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("linear",       { type = "bezier", points = { {0, 0}, {1, 1} } })

hl.animation({ leaf = "global",     enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "border",     enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "windows",    enabled = true, speed = 7,   bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7,   bezier = "linear", style = "popin 80%" })
hl.animation({ leaf = "fade",       enabled = true, speed = 7,   bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6,   bezier = "default" })

hl.config({
    dwindle = { preserve_split = true },
    master  = { new_status = "master" },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo  = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 1,
        touchpad = {
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Core apps
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + M",      hl.dsp.exit())          -- see uwsm note below
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(terminal .. " -e " .. fileManager))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",      hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen({ action = "toggle" }))

-- Move focus: arrows + vim keys
for _, pair in ipairs({ {"left","left"}, {"right","right"}, {"up","up"}, {"down","down"},
                        {"H","left"}, {"L","right"}, {"K","up"}, {"J","down"} }) do
    hl.bind(mainMod .. " + " .. pair[1], hl.dsp.focus({ direction = pair[2] }))
end

-- Move window: mainMod + SHIFT + arrows
for _, pair in ipairs({ {"left","left"}, {"right","right"}, {"up","up"}, {"down","down"} }) do
    hl.bind(mainMod .. " + SHIFT + " .. pair[1], hl.dsp.window.move({ direction = pair[2] }))
end

-- Resize window: mainMod + CTRL + arrows (repeating)
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -20, y = 0 }),  { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 20,  y = 0 }),  { repeating = true })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x = 0,   y = -20 }),{ repeating = true })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x = 0,   y = 20 }), { repeating = true })

-- Workspaces 1-10, and move window to workspace with SHIFT
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,          hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,  hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshot
hl.bind("PRINT",          hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("grim - | wl-copy"))

-- Media & volume keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
    },
    no_focus = true,
})
