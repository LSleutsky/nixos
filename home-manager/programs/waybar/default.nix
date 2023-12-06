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
        "network"
        "clock" 
      ];
      "custom/launcher" = {
        format = "";
        # on-click= "bash $HOME/.config/rofi/launcher.sh";
        # on-click-right= "bash $HOME/.config/rofi/run.sh"; 
        tooltip = "false";
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
        format="{icon} <span rise='-1.5pt'>{capacity}%</span>";
        format-alt= "{icon} <span rise='-1.5pt'>{time}</span>";
        format-icons = {
          default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          charging = ["󰢜 " "󰂆 " "󰂇 " "󰂈 " "󰢝 " "󰂉 " "󰢞 " "󰂊 " "󰂋 " "󰂅 "];
        };
        format-time = "{H}h {m}m";
        tooltip = false;
      };
      wireplumber = {
        format = "<span font='14'>{icon}</span> {volume}%";
        format-muted = "<span font='14'> </span>";
        format-icons = {
          headphone = " ";
          hands-free = "󰦢";
          headset = "󰋎";
          phone = "";
          portable = " ";
          car = " ";
          default = ["󰕿" "󰖀" "󰕾"];
        };
        reverse-scrolling = 1;
        max-volume = 100.0;
        tooltip = false;
      };
      network = {
        format-wifi = "  <span rise='-1pt'>{signalStrength}%</span>";
        format-ethernet = "󰈀 100% ";
        tooltip-format = "Connected to {essid}";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "󰖪 0% ";
      };
      clock = {
        format = "<span letter_spacing='7500'></span> <span rise='-1pt'>{:%a, %d %b %Y, %I:%M %p}</span>";
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
        font-family: ComicShannsMono Nerd Font;
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
        background: #11111b;
        margin: 5px; 
        padding: 8px 16px;
        color: #cba6f7;
      }

      #tray,
      #battery,
      #wireplumber,
      #network {
        background: #11111b;
        font-weight: bold;
        margin: 5px 0;
      }

      #tray,
      #battery,
      #wireplumber,
      #network {
        color: #f5f5f5;
        border-radius: 10px 24px 10px 24px;
        padding: 0 20px;
        margin-left: 7px;
      }
    '';
  };
}
