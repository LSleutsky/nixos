{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    settings = {
      mainBar = {
        position = "top";
        layer = "top";
        height = 35;
        margin = "0";
        fixed-center = true;
        modules-left = [
          "temperature"
          "cpu"
          "memory"
          "tray"
          "mpd"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "network"
          "backlight"
          "wireplumber"
          "battery"
          "clock"
					"clock#date"
          "idle_inhibitor"
        ];
        temperature = {
          critical-threshold = 100;
          format = "<span rise='4pt' letter_spacing='10000'></span><span rise='2pt'>{temperatureC}°C</span>";
          format-alt = "<span rise='4pt' letter_spacing='10000'></span><span rise='2pt'>{temperatureF}°F</span>";
          hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
          tooltip = false;
        };
        cpu = {
          interval = 5;
          format = "<span font='21' rise='11pt'>󰓅 </span><span font='17' rise='10pt'>{usage}%</span>";
          format-alt = "<span font='21' rise='11pt'>󰓅 </span><span font='17' rise='10pt'>{avg_frequency} GHz</span>";
          on-click = "";
        };
        memory = {
          interval = 30;
          format = "<span font='22' rise='-4pt' letter_spacing='-4400'>󰍛 </span><span font='16' rise='-4pt'>{}%</span>";
          format-alt = "<span font='22' rise='-6.5pt' letter_spacing='-4400'>󰍛 </span><span font='16' rise='-6.5pt'>{used:0.1f}GB</span>";
          tooltip-format = "{used:0.1f}GB/{total:0.1f}GB";
        };
        tray = {
          spacing = 12;
          icon-size = 25;
        };
        mpd = {
          format = "<span font='18' letter_spacing='10000'>{stateIcon}</span> <span font='17' rise='-0.75pt'>{title}</span>";
          format-disconnected = "<span font='18'>󰎊</span>";
          format-stopped = "";
          tooltip-format = "{artist} | {album}, {elapsedTime:%M:%S}/{totalTime:%M:%S}, Vol: {volume} %, Opts: {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}";
          on-click = "mpc toggle";
          state-icons = {
            paused = "";
            playing = "";
          };
          consume-icons = {
            on = "";
          };
          random-icons = {
            on = " ";
          };
          repeat-icons = {
            on = "";
          };
          single-icons = {
            on = "1";
          };
        };
        "hyprland/workspaces" = {
          format = "<span font='18'>{icon}</span>";
          on-click = "activate";
          format-icons = {
            active = "";
            default = "";
          };
        };
        network = {
          format-wifi = "<span font='19' letter_spacing='36000'>{icon}</span><span font='16'>{essid} ({signalStrength}%)</span>";
          format-ethernet = "󰈀";
          format-disconnected = "󰌙";
          format-disabled = "󱔑 ";
          format-linked = "{ifname} (No IP)";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          tooltip-format = "{essid} ({signalStrength}%)";
        };
        backlight = {
          format = "<span font='19'>{icon}</span><span font='17' rise='-2.5pt'>{percent}%</span>";
          format-icons = ["󱩎 " "󱩏 " "󱩐 " "󱩑 " "󱩒 " "󱩓 " "󱩔 " "󱩕 " "󱩖 " "󰛨 "];
          reverse-scrolling = true;
          reverse-mouse-scrolling = true;
          tooltip = false;
        };
        wireplumber = {
          format = "<span font='20' letter_spacing='30000'>{icon}</span><span font='16' rise='-1.5pt'>{volume}%</span>";
          format-muted = "<span font='21'> </span>";
          format-icons = {
            headphone = " ";
            hands-free = "󰦢";
            headset = "󰋎";
            phone = "";
            portable = " ";
            car = " ";
            default = "";
          };
          reverse-scrolling = 1;
          max-volume = 100.0;
          tooltip = false;
        };
        battery = {
          interval = 30;
          rotate = 0;
          full-at = 100;
          design-capacity = false;
          states = {
            full = 100;
            discharging = 99;
            warning = 35;
            critical = 15;
          };
          format = "<span font='19' letter_spacing='-6000'>{icon}</span> <span font='16' rise='0.5pt'>{capacity}%</span>";
          format-charging = "<span font='19'>{icon}</span><span font='16' rise='-1.2pt'>{capacity}%</span>";
          format-discharging = "<span font='19' rise='3pt' letter_spacing='-11000'>{icon}</span> <span font='16' rise='2pt'>{capacity}%</span>";
          format-plugged-full = "<span font='19' rise='4pt' letter_spacing='12000'>{icon}</span><span font='16' rise='3pt'>{capacity}%</span>";
          format-full = "<span font='19' letter_spacing='12000'>{icon}</span><span font='16' rise='-0.25pt'>{capacity}%</span>";
          format-icons = {
            default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            charging = ["󰢜 " "󰂆 " "󰂇 " "󰂈 " "󰢝 " "󰂉 " "󰢞 " "󰂊 " "󰂋 " "󰂅 "];
          };
          format-time = "{H}h {m}m";
          tooltip-format = "{time}";
        };
        clock = {
          interval = 30;
          align = 0;
          rotate = 0;
          format = "<span font='19' rise='-1.5pt' letter_spacing='30000'></span><span font='16' rise='-2.5pt'>{:%I:%M %p}</span>";
          tooltip = false;
          on-click = "";
        };
        "clock#date" = {
          interval = 30;
          align = 0;
          rotate = 0;
          format = "<span font='16' rise='-1.5pt' letter_spacing='3000'> </span><span font='16' rise='-3.5pt'>{:%a %b %d}</span>";
          tooltip = false;
          on-click = "";
        };
        idle_inhibitor = {
          format = "<span font='21'>{icon}</span>";
          format-icons = {
            activated = "󰖙";
            deactivated = "󰤄";
          };
          start-activated = false;
          timeout = false;
          tooltip = false;
        };
      };
    };
    style = ''
    * {
      font-family: ComicShannsMono Nerd Font, JetBrainsMono Nerd Font;
    }

    window#waybar {
      background: transparent;
    }

    window > box {
      margin: 7px 16px 0;
      padding: 5px 0 3px;
    }

    /* If workspaces is the leftmost module, omit left margin */
    .modules-left > widget:first-child > #workspaces {
      margin-left: 0;
    }

    /* If workspaces is the rightmost module, omit right margin */
    .modules-right > widget:last-child > #workspaces {
      margin-right: 0;
    }

      #temperature,
      #cpu,
      #memory,
      #custom-weather,
      #tray,
      #taskbar,
      #mpd,
      #workspaces,
      #network,
      #wireplumber,
      #battery,
      #clock,
      #clock#date,
      #idle_inhibitor {
        padding: 0 10px;
        font-size: 20px;
      }

      #temperature {
        padding-left: 13px;
        color: #ff9e64;
        background: #1e2030;
        border-top: 4px solid #414868;
        border-bottom: 4px solid #414868;
        border-left: 4px solid #414868;
        border-top-left-radius: 12px;
        border-bottom-left-radius: 12px;
      }

      #temperature.critical {
        color: #f7768e;
      }

      #cpu {
        color: #ff9e64;
        background: #1e2030;
        border-top: 4px solid #414868;
        border-bottom: 4px solid #414868;
      }

      #memory {
        margin-right: 11px;
        padding-left: 14px;
        color: #ff9e64;
        background: #1e2030;
        border-top: 4px solid #414868;
        border-right: 4px solid #414868;
        border-bottom: 4px solid #414868;
        border-top-right-radius: 12px;
        border-bottom-right-radius: 12px;
      }

      #tray {
        margin-right: 11px;
        padding: 0 8px 0 11px;
        background: #1e2030;
        border: 4px solid #414868;
        border-radius: 12px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        background-color: #f38ba8;
        -gtk-icon-effect: highlight;
      }

      #mpd {
        margin-right: 11px;
        padding: 4px 12px;
        background: #1e2030;
        border: 4px solid #414868;
        border-radius: 12px;
      }

      #mpd.playing {
        padding: 4px 12px;
        color: #7aaf27;
      }

      #mpd.paused {
        color: #3b4261;
      }

      #workspaces {
        background: #1e2030;
        border: 4px solid #414868;
        border-radius: 12px;
      }

      #workspaces button {
        transition: all .5s cubic-bezier(.55, -.68, .48, 1.68);
        color: #7dcfff;
        border: 0;
        box-shadow: none;
      }

      #workspaces button:hover {
        border: 0;
        box-shadow: none;
      }

      #workspaces button.active {
        transition: all .5s cubic-bezier(.55, -.68, .48, 1.68);
        color: #e0af68;
      }

      #workspaces button.active:first-child {
        padding-right: 14px;
      }

      #workspaces button.active:not(:first-child) {
        padding-right: 9px;
        padding-left: 4px;
      }

      #workspaces button.active:last-child {
        padding-left: 7px;
        padding-right: 15px;
      }

      #network {
        margin-right: 11px;
        padding-right: 13px;
        padding-left: 13px;
        color: #ff9e64;
        background: #1e2030;
        border: 4px solid #414868;
        border-radius: 12px;
      }

      #network.disconnected {
        color: #db4b4b;
        padding-right: 20px;
      }

      #backlight {
        margin-right: 11px;
        padding: 4px 18px 4px 16px;
        color: #9d7cd8;
        background: #1e2030;
        border: 4px solid #414868;
        border-radius: 12px;
      }

      #wireplumber {
        margin-right: 11px;
        padding: 4px 16px;
        color: #7aa2f7;
        background: #1e2030;
        border: 4px solid #414868;
        border-radius: 12px;
      }

      #wireplumber.muted {
        color: #ff768e;
      }

      #battery {
        margin-right: 11px;
        padding: 4px 15px 4px 16px;
        color: #9ece6a;
        font-size: 20px;
        background: #1e2030;
        border: 4px solid #414868;
        border-radius: 12px;
      }

      #battery.full {
        padding-right: 13px;
      }

      #battery.full,
      #battery.discharging {
        color: #9ece6a;
      }

      #battery.charging:not(.full) {
        padding-right: 15px;
        color: #9ece6a;
      }

      #battery.critical:not(.charging) {
        color: #f7768e;
      }

      #clock,
			#clock.date {
        margin-right: 10px;
        padding: 4px 14px;
        color: #a9b1d6;
        font-size: 21px;
        font-weight: bold;
        background: #1e2030;
        border: 4px solid #414868;
        border-radius: 12px;
      }

			#clock.date {
				color: #1abc9c;
			}

      #idle_inhibitor {
        padding: 4px 13px;
        color: #545c7e;
        font-size: 22px;
        background: #1e2030;
        border: 4px solid #414868;
        border-radius: 12px;
      }

      #idle_inhibitor.activated {
        padding: 4px 16px 4px 12px;
        color: #e0af68;
      }

      tooltip {
        padding: 15px;
        border-radius: 15px;
        background-color: #1e2030;
        font-family: ComicShannsMono Nerd Font;
        font-size: 18px;
      }

      tooltip label {
        padding: 5px;
        font-family: ComicShannsMono Nerd Font;
      }

      label:focus {
        background-color: #1e2030;
      }
      '';
    };
  }
