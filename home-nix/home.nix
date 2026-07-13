# ============================================================
# Home Manager Configuration
# ============================================================
{ config, pkgs, lib, ... }:

{
  home = {
    username    = "reladronekinse";
    homeDirectory = "/home/reladronekinse";
    stateVersion = "26.05";

    packages = with pkgs; [
      networkmanagerapplet
      bibata-cursors
    ];

    pointerCursor = {
      name    = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size    = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };

  programs.home-manager.enable = true;

  
  programs.wezterm = {
    enable = true;

    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = wezterm.config_builder()

      -- Шрифт
      config.font = wezterm.font("JetBrainsMono Nerd Font")
      config.font_size = 13.0

      -- Системные настройки и оболочка
      config.enable_wayland = true
      config.default_prog = { "fish" }
      config.window_close_confirmation = "NeverPrompt"

      -- Размеры окна (в символах) и прозрачность
      config.initial_cols = 95
      config.initial_rows = 35
      config.window_background_opacity = 0.5

      -- Отступы (в пикселях)
      config.window_padding = {
        left = 20,
        right = 20,
        top = 20,
        bottom = 20,
      }

      -- Настройка вкладок (отключение «увесистого» таб-бара для стиля, близкого к fade)
      config.use_fancy_tab_bar = false
      config.tab_max_width = 25

      -- Цветовая схема — Neovim Tokyo Night
      config.colors = {
        background = "#14151e",
        foreground = "#98b0d3",
        cursor_bg  = "#cbced3",
        cursor_fg  = "#a5b6cf",
        cursor_border = "#cbced3",
        selection_fg  = "#a5b6cf",
        selection_bg  = "#1c1e27",
        split         = "#3d59a1", -- Аналог active_border_color
        
        ansi = {
          "#151720", -- color0
          "#dd6777", -- color1
          "#90ceaa", -- color2
          "#ecd3a0", -- color3
          "#86aaec", -- color4
          "#c296eb", -- color5
          "#93cee9", -- color6
          "#cbced3", -- color7
        },
        brights = {
          "#4f5572", -- color8
          "#e26c7c", -- color9
          "#95d3af", -- color10
          "#f1d8a5", -- color11
          "#8baff1", -- color12
          "#c79bf0", -- color13
          "#98d3ee", -- color14
          "#d0d3d8", -- color15
        },
        tab_bar = {
          background = "#101014",
          active_tab = {
            bg_color  = "#16161e",
            fg_color  = "#3d59a1",
            intensity = "Bold",
          },
          inactive_tab = {
            bg_color  = "#16161e",
            fg_color  = "#787c99",
            intensity = "Bold",
          },
        },
      }

      -- Горячие клавиши (аналог kitty_mod+t: новая вкладка в текущей рабочей директории)
      config.keys = {
        {
          key = "t",
          mods = "CTRL|SHIFT",
          action = wezterm.action.SpawnTab("CurrentPaneDomain"),
        },
      }

      return config
    '';
  };

  # ── XDG config files ──────────────────────────────────────
  # ============================================================
  # Fastfetch
  # ============================================================
  xdg.configFile."fastfetch/sample.png" = {
    source = ./fastfetch/sample.png;
  };
  xdg.configFile."fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",

      "logo": {
        "type": "kitty",
        "source": "/etc/nixos/home-nix/fastfetch/sample.png",
        "width": 36,
        "height": 16
      },

      "display": {
        "separator": " ➜ ",
        "color": {
          "keys": "31;33;32;34;35",
          "title": "35",
          "output": "97",
          "separator": "90"
        },
        "brightColor": true,
        "duration": {
          "abbreviation": false,
          "spaceBeforeUnit": "default"
        },
        "size": {
          "maxPrefix": "YB",
          "binaryPrefix": "iec",
          "ndigits": 2,
          "spaceBeforeUnit": "default"
        },
        "temp": {
          "unit": "D",
          "ndigits": 1,
          "color": {
            "green": "32",
            "yellow": "93",
            "red": "91"
          },
          "spaceBeforeUnit": "default"
        },
        "percent": {
          "type": ["num", "num-color"],
          "ndigits": 0,
          "color": {
            "green": "32",
            "yellow": "93",
            "red": "91"
          },
          "spaceBeforeUnit": "default",
          "width": 0
        },
        "bar": {
          "char": {
            "elapsed": "■",
            "total": "-"
          },
          "border": {
            "left": "[ ",
            "right": " ]",
            "leftElapsed": "",
            "rightElapsed": ""
          },
          "color": {
            "elapsed": "auto",
            "total": "97",
            "border": "97"
          },
          "width": 10
        },
        "fraction": {
          "ndigits": 2
        },
        "noBuffer": false,
        "key": {
          "width": 0,
          "type": "string",
          "paddingLeft": 0
        },
        "freq": {
          "ndigits": 2,
          "spaceBeforeUnit": "default"
        },
        "constants": []
      },

      "general": {
        "thread": true,
        "processingTimeout": 5000,
        "detectVersion": true,
        "playerName": "",
        "dsForceDrm": false
      },

      "modules": [
        {
          "type": "title",
          "key": "",
          "keyColor": "35"
        },
        {
          "type": "separator",
          "string": " "
        },
        {
          "type": "os",
          "key": "",
          "keyColor": "34"
        },
        {
          "type": "host",
          "key": "󰌢",
          "keyColor": "32"
        },
        {
          "type": "kernel",
          "key": "󰒔",
          "keyColor": "35"
        },
        {
          "type": "uptime",
          "key": "󱎫",
          "keyColor": "33"
        },
        {
          "type": "packages",
          "key": "󰏖",
          "keyColor": "31"
        },
        {
          "type": "shell",
          "key": "",
          "keyColor": "36"
        },
        {
          "type": "display",
          "key": "󰍹",
          "keyColor": "34"
        },
        {
          "type": "de",
          "key": "󰧨",
          "keyColor": "32"
        },
        {
          "type": "wm",
          "key": "",
          "keyColor": "35"
        },
        {
          "type": "theme",
          "key": "󰉼",
          "keyColor": "33"
        },
        {
          "type": "icons",
          "key": "󰀻",
          "keyColor": "31"
        },
        {
          "type": "terminal",
          "key": "",
          "keyColor": "36"
        },
        {
          "type": "cpu",
          "key": "",
          "keyColor": "34"
        },
        {
          "type": "gpu",
          "key": "󰾲",
          "keyColor": "32"
        },
        {
          "type": "memory",
          "key": "",
          "keyColor": "35"
        },
        {
          "type": "disk",
          "key": "󰋊",
          "keyColor": "33"
        },
        {
          "type": "battery",
          "key": "",
          "keyColor": "31"
        },
        "break",
        {
          "type": "colors",
          "key": "",
          "symbol": "circle"
        }
      ]
    }
  '';


  # ============================================================
  # Niri
  # ============================================================
  xdg.configFile."niri/config.kdl".text = ''
    // Input device configuration.
    input {
        keyboard {
            xkb {
                layout "us,ru"
                options "grp:win_space_toggle,compose:ralt,ctrl:nocaps"
            }
            numlock
        }

        touchpad {
            tap
            natural-scroll
        }

        warp-mouse-to-focus
        focus-follows-mouse max-scroll-amount="0%"
    }

    // Spawn at startup
    spawn-at-startup "nm-applet"
    spawn-at-startup "ironbar"
    spawn-at-startup "awww-daemon"
    spawn-sh-at-startup "sleep 1 && awww img /etc/nixos/home-nix/niri/sample.jpg"
    spawn-at-startup "mako"
    spawn-at-startup "xwayland-satellite"
    spawn-at-startup "systemctl" "--user" "import-environment" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"
    spawn-at-startup "systemctl" "--user" "restart" "xdg-desktop-portal.service"

    // Environment variables
    environment {
        XDG_CURRENT_DESKTOP "niri"
        XCURSOR_THEME "Bibata-Modern-Classic"
        XCURSOR_SIZE "24"
        DISPLAY ":0"
        // Для Qt-приложений (например, Telegram, VLC)
        QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
        // Для GTK-приложений (иногда помогает)
        GTK_CSD "0"
    }
    prefer-no-csd
    // Outputs
    output "DP-2" {
        mode "2560x1440@164.998"
        position x=0 y=0
        variable-refresh-rate
    }

    output "HDMI-A-1" {
        mode "1280x1024@75.025"
        position x=2560 y=0
    }

    // Layout
    layout {
        gaps 16
        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        focus-ring {
            width 4
            active-color "#7fc8ff"
            inactive-color "#505050"
        }

        border {
            off
            width 4
            active-color "#cba6f7"
            inactive-color "#45475a"
            urgent-color "#9b0000"
        }

    }

    // Screenshot path
    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    // Gestures
    gestures {
        hot-corners {
            off
        }
    }

    // Animations
    animations { }

    // Window rules
    window-rule {
        geometry-corner-radius 12
        clip-to-geometry true
    }
    window-rule {
        match app-id=r#"^org\.wezfurlong\.wezterm$"#
        default-column-width {}
    }

    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        open-floating true
    }

    // Keybindings
    binds {
        Mod+Shift+Slash { show-hotkey-overlay; }
        Mod+Q { spawn "wezterm"; }
        Mod+R { spawn "wofi" "--show" "drun"; }
        Super+Alt+L { spawn "swaylock"; }

        Mod+C repeat=false { close-window; }
        Mod+O repeat=false { toggle-overview; }
        Mod+V { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }
        Mod+W { toggle-column-tabbed-display; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+Ctrl+F { expand-column-to-available-width; }
        Mod+Ctrl+C { center-visible-columns; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }
        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        Mod+WheelScrollDown      { focus-column-right; }
        Mod+WheelScrollUp        { focus-column-left; }
        Mod+Ctrl+WheelScrollDown { move-column-right; }
        Mod+Ctrl+WheelScrollUp   { move-column-left; }
        Mod+Shift+WheelScrollDown { focus-workspace-down; }
        Mod+Shift+WheelScrollUp   { focus-workspace-up; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }

        Mod+Tab { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }

        Mod+Shift+E { quit; }
        Ctrl+Alt+Delete { quit; }
        Mod+Shift+P { power-off-monitors; }
        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
        XF86AudioMute        allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
        XF86AudioPlay        allow-when-locked=true { spawn-sh "playerctl play-pause"; }
        XF86AudioStop        allow-when-locked=true { spawn-sh "playerctl stop"; }
        XF86AudioPrev        allow-when-locked=true { spawn-sh "playerctl previous"; }
        XF86AudioNext        allow-when-locked=true { spawn-sh "playerctl next"; }
        XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }
    }
  '';

  # ============================================================
  # Fish
  # ============================================================
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting
      fastfetch
    '';

    plugins = [
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    ];
  };

  # ============================================================
  # Ironbar
  # ============================================================
  xdg.configFile."ironbar/style.css".text = ''
    /* Базовые настройки для всей панели */
    * {
      font-family: "JetBrainsMono Nerd Font", sans-serif;
      font-size: 13px;
      border: none;
      border-radius: 0;
      background: none; /* Убирает дефолтные белые фоны у виджетов */
    }

    /* Фон самой панели (Catppuccin Mocha Crust) */
    window {
      background-color: #11111b;
      color: #cdd6f4;
    }

    /* Контейнер, который держит левую, центральную и правую части */
    .mainbar {
      padding: 0 8px;
    }

    /* Стили для кнопок воркспейсов */
    .workspace {
      color: #6c7086; /* Overlay 0 */
      padding: 0 12px;
      background-color: transparent;
    }

    .workspace.active {
      color: #cba6f7; /* Mauve */
      background-color: #313244; /* Surface 0 */
      border-radius: 4px;
    }

    .workspace.urgent {
      color: #f38ba8; /* Red */
    }

    /* Текст активного окна по центру */
    .focused {
      color: #bac2de;
    }

    /* Настройка правого блока: делаем отступы между элементами */
    .end > widget > * {
      padding: 0 10px;
      margin: 2px 4px;
      border-radius: 4px;
      background-color: #1e1e2e; /* Base */
    }

    /* Цвета для конкретных элементов в конце панели */
    .network { color: #89b4fa; }
    .sysinfo { color: #a6e3a1; } /* Для процессора/памяти */
    .volume { color: #a6e3a1; }
    .battery { color: #f9e2af; }
    .clock {
      color: #cba6f7;
      font-weight: bold;
    }

    /* Системный лоток (трей) */
    .tray {
      background-color: transparent;
      padding: 0 4px;
    }
  '';

  # ============================================================
  # Wofi
  # ============================================================
  programs.wofi = {
    enable = true;

    settings = {
      width          = 400;
      height         = 500;
      location       = "center";
      show           = "drun";
      prompt         = "Search...";
      filter_rate    = 100;
      allow_markup   = true;
      no_actions     = true;
      halign         = "fill";
      orientation    = "vertical";
      content_halign = "fill";
      insensitive    = true;
      allow_images   = true;
      image_size     = 16;
      gtk_dark       = true;
      exec_shell     = true;
    };

    style = ''
      window {
          background-color: #1a1525;
          border: 1px solid #6c4fa3;
          font-family: sans-serif;
          font-size: 14px;
      }

      #input {
          background-color: #241b35;
          color: #d4b8f0;
          border: 1px solid #6c4fa3;
          border-radius: 8px;
          padding: 8px 12px;
          margin: 8px;
          outline: none;
          caret-color: #a07ad4;
      }

      #input::placeholder { color: #6b5490; }

      #outer-box { padding: 4px; }
      #scroll    { margin: 0 4px 4px 4px; }
      #inner-box { background: transparent; }

      #entry {
          padding: 6px 10px;
          border-radius: 8px;
          color: #c9a8f0;
      }

      #entry:selected {
          background-color: #3d2460;
          color: #e8d4ff;
      }

      #entry image { margin-right: 8px; }
      #text { color: inherit; }
    '';
  };
}
