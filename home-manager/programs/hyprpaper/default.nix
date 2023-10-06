{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [ hyprpaper ];
    file.".config/hypr/hyprpaper.conf" = {
      enable = true;
      text = ''
        preload = ~/nixos/home-manager/programs/hyprpaper/wallpapers/glowing-black-hole.png

        wallpaper = eDP-1, ~/nixos/home-manager/programs/hyprpaper/wallpapers/glowing-black-hole.png
      '';
    };
  };
}