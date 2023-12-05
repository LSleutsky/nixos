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
        "custom/playerctl#backward" 
        "custom/playerctl#play" 
        "custom/playerctl#foward" 
        "custom/playerlabel"
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
      clock = {
        format = " {:%a, %d %b, %I:%M %p}";
        tooltip = "true";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = " {:%d/%m}";
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
      "custom/playerctl#backward" = {
        format = "󰙣 ";
        on-click = "playerctl previous";
        on-scroll-up = "playerctl volume .05+";
        on-scroll-down = "playerctl volume .05-";
      };
      "custom/playerctl#play" = {
        format = "{icon}";
        return-type = "json";
        exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
        on-click = "playerctl play-pause";
        on-scroll-up = "playerctl volume .05+";
        on-scroll-down = "playerctl volume .05-";
        format-icons = {
          Playing = "<span>󰏥 </span>";
          Paused = "<span> </span>";
          Stopped = "<span> </span>";
        };
      };
      "custom/playerctl#foward" = {
        format = "󰙡 ";
        on-click = "playerctl next";
        on-scroll-up = "playerctl volume .05+";
        on-scroll-down = "playerctl volume .05-";
      };
      "custom/playerlabel" = {
        format = "<span>󰎈 {} 󰎈</span>";
        return-type = "json";
        max-length = 40;
        exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
        on-click = "";
      };
      battery = {
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        format ="{icon}  {capacity}%";
        format-charging = "  {capacity}%";
        format-plugged = " {capacity}% ";
        format-alt = "{icon} {time}";
        format-icons = ["" "" "" "" ""];
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
      network = {
        format-wifi = "  {signalStrength}%";
        format-ethernet = "󰈀 100% ";
        tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "󰖪 0% ";
      };
      tray = {
        icon-size = 20;
        spacing = 8;
      };
      wireplumber = {
        format = "<span font='16'>{icon}</span> {volume}%";
        format-muted = "<span font='16'> </span>";
        format-icons = {
          headphone = " ";
          hands-free = "󰦢";
          headset = "󰋎";
          phone = "";
          portable = " ";
          car = " ";
          default= ["󰕿" "󰖀" "󰕾"];
        };
        reverse-scrolling = 1;
        max-volume = 100.0;
        tooltip = false;
      };
      "custom/launcher" = {
        format = "";
        # on-click= "bash $HOME/.config/rofi/launcher.sh";
        # on-click-right= "bash $HOME/.config/rofi/run.sh"; 
        tooltip = "false";
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0px;
        font-family: ComicShannsMono Nerd Font;
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(17, 17, 27, 1);
      }

      #cava.left, #cava.right {
        background: #25253a;
        margin: 5px; 
        padding: 8px 16px;
        color: #cba6f7;
      }

      #cava.left {
        border-radius: 24px 10px 24px 10px;
      }

      #cava.right {
        border-radius: 10px 24px 10px 24px;
      }

      #workspaces {
        background: #25253a;
        margin: 5px 5px;
        padding: 8px 5px;
        border-radius: 16px;
        color: #cba6f7;
      }

      #workspaces button {
        padding: 0px 5px;
        margin: 0px 3px;
        border-radius: 16px;
        color: transparent;
        background: rgba(17, 17, 27, 1);
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

      #tray, #wireplumber, #network, #battery,
      #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.foward {
        background: #25253a;
        font-weight: bold;
        margin: 5px 0px;
      }

      #tray, #wireplumber, #network, #battery {
        color: #f5f5f5;
        border-radius: 10px 24px 10px 24px;
        padding: 0 20px;
        margin-left: 7px;
      }

      #clock {
        color: #f5f5f5;
        background: #25253a;
        border-radius: 0px 0px 0px 40px;
        padding: 10px 10px 15px 25px;
        margin-left: 7px;
        font-weight: bold;
        font-size: 16px;
      }

      #custom-launcher {
        color: #89b4fa;
        background: #25253a;
        border-radius: 0px 0px 40px 0px;
        margin: 0px;
        padding: 0px 35px 0px 15px;
        font-size: 28px;
      }

      #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.foward {
        background: #25253a;
        font-size: 22px;
      }

      #custom-playerctl.backward:hover, #custom-playerctl.play:hover, #custom-playerctl.foward:hover {
        color: #f5f5f5;
      }

      #custom-playerctl.backward {
        color: #cba6f7;
        border-radius: 24px 0px 0px 10px;
        padding-left: 16px;
        margin-left: 7px;
      }

      #custom-playerctl.play {
        color: #89b4fa;
        padding: 0 5px;
      }

      #custom-playerctl.foward {
        color: #cba6f7;
        border-radius: 0px 10px 24px 0px;
        padding-right: 12px;
        margin-right: 7px
      }

      #custom-playerlabel {
        background: #25253a;
        color: #f5f5f5;
        padding: 0 20px;
        border-radius: 24px 10px 24px 10px;
        margin: 5px 0;
        font-weight: bold;
      }

      #window {
        background: #25253a;
        padding-left: 15px;
        padding-right: 15px;
        border-radius: 16px;
        margin-top: 5px;
        margin-bottom: 5px;
        font-weight: normal;
        font-style: normal;
      }
    '';
  };
}
