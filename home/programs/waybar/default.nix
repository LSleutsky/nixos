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
        ];
        modules-center = [ "wlr/workspaces" ];
        modules-right = [
          "bluetooth"
          "network"
          "backlight"
          "wireplumber"
          "battery"
          "clock"
          "idle_inhibitor"
        ];
      };
    };
  };
}
