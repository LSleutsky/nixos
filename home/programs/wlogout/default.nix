{ config, lib, pkgs, ... }:

{
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
        font-family: "ComicShannsMono Nerd Font", "JetBrains Mono Nerd Font", sans-serif;
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
        background-image: url("/home/lush/nixos/home/programs/wlogout/assets/lock.png");
      }

      #lock:focus {
        background-image: url("/home/lush/nixos/home/programs/wlogout/assets/lock-hover.png");
      }

      #logout {
        background-image: url("/home/lush/nixos/home/programs/wlogout/assets/logout.png");
      }

      #logout:focus {
        background-image: url("/home/lush/nixos/home/programs/wlogout/assets/logout-hover.png");
      }

      #suspend {
        background-image: url("/home/lush/nixos/home/programs/wlogout/assets/suspend.png");
      }

      #suspend:focus {
        background-image: url("/home/lush/nixos/home/programs/wlogout/assets/suspend-hover.png");
      }

      #shutdown {
        background-image: url("/home/lush/nixos/home/programs/wlogout/assets/shutdown.png");
      }

      #shutdown:focus {
        background-image: url("/home/lush/nixos/home/programs/wlogout/assets/shutdown-hover.png");
      }

      #reboot {
        background-image: url("/home/lush/nixos/home/programs/wlogout/assets/reboot.png");
      }

      #reboot:focus {
        background-image: url("/home/lush/nixos/home/programs/wlogout/assets/reboot-hover.png");
      }
    '';
  };
}
