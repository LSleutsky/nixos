{ config, lib, pkgs, ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      background_update = true;
      check_temp = true;
      rounded_corners = true;
      show_battery = true;
      show_coretemp = true;
      show_uptime = true;
      truecolor = true;
      update_ms = 2000;
      vim_keys = true;
    };
  };
}
