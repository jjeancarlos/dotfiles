---@diagnostic disable: undefined-global
-- #######################################################################################
-- MIGRADO DE hyprland.conf (hyprlang) PARA hyprland.lua
-- Hyprland instalado no momento da migração: 0.56.2 (hyprlang 0.6.8 ainda ativo/suportado)
-- Alvo: 0.57.x — hyprlang ainda não tem data confirmada de remoção, mantenha o .conf
-- original guardado até validar este arquivo em produção.
--
-- Pontos marcados com "-- ⚠ VERIFICAR" não tiveram a sintaxe exata confirmada na
-- documentação oficial no momento da migração — confira com `hyprctl` / wiki antes
-- de confiar neles.
-- #######################################################################################

-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can split this configuration into multiple files
-- Create your files separately and then link them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({ output = "DP-2", mode = "1920x1080@144", position = "0x0", scale = 1, transform = 3 })
hl.monitor({ output = "DP-1", mode = "1920x1080@240", position = "1080x0", scale = 1 })

---------------------
---- MY PROGRAMS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Variables/

-- Set programs that you use
local screenshot = "hyprshot"
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "rofi -show drun"
local warp = "warp-terminal"


-------------------
---- AUTOSTART ----
-------------------

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
    -- hl.exec_cmd(terminal)
    -- hl.exec_cmd("nm-applet &")
    -- hl.exec_cmd("waybar & hyprpaper & firefox")

    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    hl.exec_cmd("dunst")
    hl.exec_cmd("kbuildsycoca6")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("gtk-launch brave-pjibgclleladliembfgfagdaldikeohf-Default")
    hl.exec_cmd("wl-paste --type text --watch cliphist store --max-items 100") -- Stores only text data
    hl.exec_cmd("wl-paste --type text --watch-primary cliphist store")
    -- hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data
    hl.exec_cmd("waybar")
    hl.exec_cmd("ratbagd")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/reset-portals.sh")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/ssh-add.sh")
    -- Autostart
    hl.exec_cmd("steam -silent")
    -- hl.exec_cmd("vesktop")
    hl.exec_cmd("/usr/bin/electron40 /usr/lib/vesktop/app.asar")
    hl.exec_cmd("piper -silent")
    -- hl.exec_cmd("linux-wallpaperengine --screen-root DP-3 3111326350 --scaling fill --fps 30 --assets-quality low --set-property showseconds=0 --silent &")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("GDK_SCALE", "1")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("AQ_NO_MODIFIERS", "1")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--     ecosystem = { enforce_permissions = true },
-- })
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL -----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    general = {
        -- no_cursor_warps = true,
        gaps_in = 5,
        gaps_out = 20,

        border_size = 2,

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#variable-types for info about colors
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 0.95,
        inactive_opacity = 0.95,

        shadow = {
            enabled = true,
            range = 25,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
        blur = {
            enabled = true,
            size = 8,
            passes = 3,           -- Aumentado para um efeito acrílico mais suave
            vibrancy = 0.1696,
            ignore_opacity = true, -- Garante que o blur apareça atrás de janelas transparentes
            noise = 0.0,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
-- animations:enabled=false () desabilita todas as animações
hl.config({
    animations = {
        enabled = true,
    },
})

-- =====================================================
-- Curvas sofisticadas / premium feel (baseadas em easings.net + overshoots)
-- =====================================================
hl.curve("easeOutCubic",   { type = "bezier", points = { { 0.215, 0.61 },  { 0.355, 1 } } })    -- suave final, elegante
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.645, 0.045 }, { 0.355, 1 } } })    -- equilíbrio premium
hl.curve("overshootElite", { type = "bezier", points = { { 0.175, 0.885 }, { 0.32, 1.275 } } }) -- bounce sutil + overshoot luxuoso
hl.curve("backOut",        { type = "bezier", points = { { 0.175, 0.885 }, { 0.32, 1.275 } } }) -- back com elastic feel
hl.curve("elasticOut",     { type = "bezier", points = { { 0.34, 1.56 },   { 0.64, 1 } } })     -- elastic leve (use com cuidado)

-- =====================================================
-- Globais + border premium (gradiente + fade suave)
-- =====================================================
hl.animation({ leaf = "global",      enabled = true, speed = 2, bezier = "easeInOutCubic" })
hl.animation({ leaf = "border",      enabled = true, speed = 3, bezier = "easeOutCubic" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 4, bezier = "easeInOutCubic", style = "loop" }) -- ⚠ VERIFICAR: "loop" como style ainda não confirmado na doc oficial da 0.56/0.57

-- =====================================================
-- Janelas - cinematic open/close com popin + bounce
-- =====================================================
hl.animation({ leaf = "windows",     enabled = true, speed = 2, bezier = "overshootElite", style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 3, bezier = "backOut",        style = "popin 85%" }) -- abre crescendo com bounce elegante
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 2, bezier = "easeOutCubic",   style = "popin 70%" }) -- fecha retraindo suave
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2, bezier = "easeInOutCubic", style = "slide" })     -- mover/redimensionar fluido

-- =====================================================
-- Fade refinado (anti-glitch + premium opacity)
-- =====================================================
hl.animation({ leaf = "fade",       enabled = true, speed = 3, bezier = "easeOutCubic" })
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 2, bezier = "easeInOutCubic" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 2, bezier = "easeOutCubic" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 2, bezier = "easeOutCubic" })   -- troca de foco suave
hl.animation({ leaf = "fadeDim",    enabled = true, speed = 3, bezier = "easeInOutCubic" }) -- dim inactive windows elegante

-- =====================================================
-- Layers / menus / popups (rofi, notifications, waybar) - fade + pop premium
-- =====================================================
hl.animation({ leaf = "layers",        enabled = true, speed = 2, bezier = "easeInOutCubic", style = "fade" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 2, bezier = "overshootElite", style = "popin 90%" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1, bezier = "easeOutCubic" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 2, bezier = "easeOutCubic" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2, bezier = "easeOutCubic" })
hl.animation({ leaf = "fadePopups",    enabled = true, speed = 2, bezier = "easeInOutCubic" }) -- popups wayland nativos suaves

-- =====================================================
-- Workspaces - slidefade ou slidevert com overshoot leve
-- =====================================================
hl.animation({ leaf = "workspaces",    enabled = true, speed = 3, bezier = "easeInOutCubic", style = "slidefade 70%" }) -- fade + slide premium
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 3, bezier = "overshootElite", style = "slidefade 80%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2, bezier = "easeOutCubic",   style = "slidefade 60%" })

-- Opcional: se preferir vertical (muito elegante em ultrawide ou portrait)
-- hl.animation({ leaf = "workspaces",   enabled = true, speed = 3, bezier = "easeInOutCubic", style = "slidevert" })
-- hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3, bezier = "overshootElite", style = "slidevert" })

-- =====================================================
-- Extras premium (special workspaces, zoom etc)
-- =====================================================
hl.animation({ leaf = "specialWorkspace",    enabled = true, speed = 2, bezier = "backOut",        style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 3, bezier = "overshootElite", style = "slidefadevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 2, bezier = "easeOutCubic" })


-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name = "no-gaps-wtv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ name = "no-gaps-f1", match = { float = false, workspace = "f[1]" }, border_size = 0, rounding = 0 })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,

        -- Isso ajuda a evitar que o portal se perca entre sessões
        initial_workspace_tracking = 0,

        disable_splash_rendering = true,

        -- Desativa o Variable Refresh Rate (FreeSync)
        vrr = 0,

        font_family = "Sans",
    },
})

hl.config({
    debug = {
        -- Variable Frame Rate
        vfr = true,
    },
})

hl.config({
    render = {
        cm_enabled = false,
    },
})


-------------
---- INPUT ----
-------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout = "br",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Example per-device config (placeholder do template padrão — "epic-mouse-v1" não é um
-- device real deste sistema; deixei comentado. Se quiser configurar um mouse/teclado
-- de verdade, pegue o nome com `hyprctl devices` e descomente/ajuste.)
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
-- hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

-- plugin csgo-vulkan-fix (inativo no seu .conf original, mantido inativo aqui)
-- hl.plugin.load("/caminho/para/csgo-vulkan-fix.so")
-- hl.config({
--     plugin = {
--         ["csgo-vulkan-fix"] = {
--             fix_mouse = true,
--             class = "SDL Application",
--             ["vkfix-app"] = { "cs2, 1280, 960", "myapp, 1920, 1080" },
--         },
--     },
-- })


-----------------
---- KEYBINDINGS ----
-----------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(warp))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + K", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(screenshot .. " -m window"))
hl.bind("Print", hl.dsp.exec_cmd(screenshot .. " -m region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " -m output"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })) -- ⚠ VERIFICAR: string exata de "mode" para fullscreen real não confirmada (só "maximized" está documentado em exemplo)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"), { locked = true })


----------------------------
---- WINDOWS AND WORKSPACES ----
----------------------------

-- Monitor Vertical (Fixo e persistente)
-- hl.workspace_rule({ workspace = "1", monitor = "DP-2", persistent = true })

-- Monitor Principal de 240Hz (O workspace 2 inicia aberto junto com o sistema)
-- hl.workspace_rule({ workspace = "2", monitor = "DP-1", persistent = true })

-- Vincula o restante do teclado padrão para abrir sempre no DP-1
for i = 1, 9 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1" })
end
hl.workspace_rule({ workspace = "10", monitor = "DP-2" })

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules

-- Example windowrule
-- hl.window_rule({ match = { class = "^(kitty)$", title = "^(kitty)$" }, float = true })

-- Ignore maximize requests from apps. You'll probably like this.
-- Regra geral para suprimir eventos de maximizar
-- 1. Suprimir eventos de maximizar (usando regex puro para a classe)
-- hl.window_rule({ name = "suppress-maximize-events", match = { class = ".*" }, suppress_event = "maximize" })

-- 2. Fix para XWayland (nofocus)
-- hl.window_rule({ name = "fix-xwayland-drags", match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false }, no_focus = true })

-- --- Correções para Steam ---

-- 3. Forçar janelas secundárias a flutuar
-- hl.window_rule({ match = { title = "^(?!Steam).*$" }, float = true })

-- 4. Corrigir menus e minsize
-- hl.window_rule({ match = { title = "^$" }, stay_focused = true })
-- hl.window_rule({ match = { title = "^$" }, minsize = { 1, 1 } })

-- 5. Impedir que a Steam roube o foco
-- hl.window_rule({ match = { class = "steam" }, focus_on_activate = false })

-- --- LAYER RULES ---

hl.layer_rule({
    name = "blur_waybar",
    match = { namespace = "waybar" },
    blur = true,
    ignore_alpha = 0.4, -- ⚠ VERIFICAR: nome exato do campo (ignore_alpha vs ignorealpha) não confirmado em exemplo oficial de hl.layer_rule
})

hl.layer_rule({
    name = "blur_notifications",
    match = { namespace = "notifications" },
    blur = true,
    ignore_alpha = 0.4, -- ⚠ VERIFICAR (mesmo motivo acima)
})

hl.layer_rule({
    name = "blur_rofi",
    match = { namespace = "rofi" },
    blur = true,
    ignore_alpha = 0.1, -- ⚠ VERIFICAR (mesmo motivo acima)
})
