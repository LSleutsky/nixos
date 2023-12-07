{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    settings.mainBar = {
      position = "top";
      layer = "top";
      height = 35;
      margin-top = 0;
      margin-bottom = 0;
      margin-left = 0;
      margin-right = 0;
      modules-left = [
        "custom/launcher" 
      ];
      modules-center = [
        "cava#left"
        "hyprland/workspaces"
        "cava#right"
      ];
      modules-right = [
        "tray" 
        "battery"
        "wireplumber" 
        "backlight"
        "network"
        "clock" 
      ];
      "custom/launcher" = {
        format = "";
        on-click = "${pkgs.rofi}/bin/rofi -show drun";
        tooltip = false;
      };
      "cava#left" = {
        framerate = 60;
        autosens = 1;
        bars = 18;
        lower_cutoff_freq = 50;
        higher_cutoff_freq = 10000;
        method = "pipewire";
        source = "auto";
        stereo = true;
        reverse = false;
        bar_delimiter = 0;
        monstercat = false;
        waves = false;
        input_delay = 2;
        format-icons = [ 
          "<span foreground='#cba6f7'>▁</span>" 
          "<span foreground='#cba6f7'>▂</span>" 
          "<span foreground='#cba6f7'>▃</span>" 
          "<span foreground='#cba6f7'>▄</span>" 
          "<span foreground='#89b4fa'>▅</span>" 
          "<span foreground='#89b4fa'>▆</span>" 
          "<span foreground='#89b4fa'>▇</span>" 
          "<span foreground='#89b4fa'>█</span>" 
        ];
      };
      "hyprland/workspaces" = {
        active-only = false;
        all-outputs = false;
        disable-scroll = false;
        on-scroll-up = "hyprctl dispatch workspace e-1";
        on-scroll-down = "hyprctl dispatch workspace e+1";
        format = "{name}";
        on-click= "activate";
        format-icons = {
          urgent = "";
          active = "";
          default = "";
          sort-by-number = true;
        };
      };
      "cava#right" = {
        framerate = 60;
        autosens = 1;
        bars = 18;
        lower_cutoff_freq = 50;
        higher_cutoff_freq = 10000;
        method = "pipewire";
        source = "auto";
        stereo = true;
        reverse = false;
        bar_delimiter = 0;
        monstercat = false;
        waves = false;
        input_delay = 2;
        format-icons = [ 
          "<span foreground='#cba6f7'>▁</span>" 
          "<span foreground='#cba6f7'>▂</span>" 
          "<span foreground='#cba6f7'>▃</span>" 
          "<span foreground='#cba6f7'>▄</span>" 
          "<span foreground='#89b4fa'>▅</span>" 
          "<span foreground='#89b4fa'>▆</span>" 
          "<span foreground='#89b4fa'>▇</span>" 
          "<span foreground='#89b4fa'>█</span>" 
        ];
      };
      tray = {
        icon-size = 20;
        spacing = 8;
      };
      battery = {
        interval = 30;
        full-at = 100;
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        format="{icon}  {capacity}%";
        format-alt= "{icon}  {time}";
        format-icons= ["" "" "" "" ""];
        format-time = "{H}h {m}m";
        tooltip = false;
      };
      wireplumber = {
        format = "<span font='15'>{icon}</span> <span rise='1.5pt'>{volume}%</span>";
        format-muted = "<span font='13'> </span>";
        format-icons = {
          headphone = " ";
          hands-free = "󰦢";
          headset = "󰋎";
          phone = "";
          portable = " ";
          car = " ";
          default = ["󰕿" "󰖀" "󰕾"];
        };
        on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 2%+";
        on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 2%-";
        reverse-scrolling = 1;
        max-volume = 100.0;
        tooltip = false;
      };
      backlight = {
        format = "{icon} {percent}%";
        format-icons = ["󰃚" "󰃛" "󰃜" "󰃝" "󰃞" "󰃟" "󰃠"];
        reverse-scrolling = true;
        reverse-mouse-scrolling = true;
        on-scroll-up = "${pkgs.brillo}/bin/brillo -A 2";
        on-scroll-down = "${pkgs.brillo}/bin/brillo -U 2";
        tooltip = false;
      };
      network = {
        format-wifi = "  {signalStrength}%";
        format-ethernet = "󰈀 100% ";
        tooltip-format = "Connected to {essid}";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "󰖪 0% ";
      };
      clock = {
        format = " {:%a, %d %b %Y, %I:%M %p}";
        tooltip = "false";
        tooltip-format = "<tt><big>{calendar}</big></tt>";
      };
      memory = {
        format = "󰍛 {}%";
        format-alt = "󰍛 {used}/{total} GiB";
        interval = 5;
      };
      cpu = {
        format = "󰻠 {usage}%";
        format-alt = "󰻠 {avg_frequency} GHz";
        interval = 5;
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "RobotoMono Nerd Font", "ComicShannsMono Nerd Font", "JetBrains Mono Nerd Font", sans-serif;
        font-size: 14px;
        min-height: 0;
      }

      #window {
        background: #11111b;
        padding-left: 15px;
        padding-right: 15px;
        border-radius: 16px;
        margin-bottom: 5px;
        font-weight: normal;
        font-style: normal;
      }

      window#waybar {
        background: #25253a;
      }

      #custom-launcher {
        color: #89b4fa;
        background: #11111b;
        border-radius: 0 0 40px 0px;
        margin: 0;
        padding: 0 35px 0 15px;
        font-size: 28px;
      }

      #cava.left {
        border-radius: 24px 10px 24px 10px;
      }

      #workspaces {
        background: #11111b;
        margin: 5px 5px;
        padding: 8px 5px;
        border-radius: 16px;
        color: #cba6f7;
      }

      #workspaces button {
        padding: 0 5px;
        margin: 0 3px;
        border-radius: 16px;
        color: transparent;
        background: #25253a;
        transition: all 0.3s ease-in-out;
      }

      #workspaces button.active {
        background-color: #89b4fa;
        color: #11111b;
        border-radius: 16px;
        min-width: 50px;
        background-size: 400% 400%;
        transition: all 0.3s ease-in-out;
      }

      #workspaces button:hover {
        background-color: #f5f5f5;
        color: #11111b;
        border-radius: 16px;
        min-width: 50px;
        background-size: 400% 400%;
      }

      #cava.right {
        border-radius: 10px 24px 10px 24px;
      }

      #clock {
        color: #f5f5f5;
        background: #11111b;
        border-radius: 0 0 0 40px;
        padding: 10px 10px 15px 25px;
        margin-left: 7px;
        font-weight: bold;
        font-size: 16px;
      }

      #cava.left,
      #cava.right {
        background: #25253a;
        margin: 5px; 
        padding: 8px 16px;
        color: #cba6f7;
      }

      #tray,
      #battery,
      #wireplumber,
      #backlight,
      #network {
        background: #11111b;
        font-weight: bold;
        color: #f5f5f5;
        border-radius: 10px 24px 10px 24px;
        padding: 0 20px;
        margin: 5px 0 5px 7px;
      }
    '';
  };
}
