{ config, lib, pkgs, ... }:

let
  home = "/home/lush/nixos/home-manager/programs/wlogout/assets";
in {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "swaylock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
    ];
    style = ''
      window {
        font-family: "RobotoMono Nerd Font", "ComicShannsMono Nerd Font", "JetBrains Mono Nerd Font", sans-serif;
        font-size: 16px;
        font-weight: 900;
        color: #cdd6f4;
        background-color: rgba(30, 30, 46, 0.5);
      }

      button {
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        border: none;
        background-color: rgba(30, 30, 46, 0);
        box-shadow: none;
        margin: 5px;
        font-size: 20px;
        color: #cdd6f4;
      }

      button:hover {
        background-color: rgba(49, 50, 68, 0.1);
      }

      button:focus {
        background-color: #cba6f7;
        color: #11111b;
      }

      #lock {
        background-image: url("${home}/lock.png");
      }

      #lock:focus {
        background-image: url("${home}/lock-hover.png");
      }

      #logout {
        background-image: url("${home}/logout.png");
      }

      #logout:focus {
        background-image: url("${home}/logout-hover.png");
      }

      #suspend {
        background-image: url("${home}/suspend.png");
      }

      #suspend:focus {
        background-image: url("${home}/suspend-hover.png");
      }

      #shutdown {
        background-image: url("${home}/shutdown.png");
      }

      #shutdown:focus {
        background-image: url("${home}/shutdown-hover.png");
      }

      #reboot {
        background-image: url("${home}/reboot.png");
      }

      #reboot:focus {
        background-image: url("${home}/reboot-hover.png");
      }
    '';
  };
}
