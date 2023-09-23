{ config, lib, pkgs, ... }:

{
  programs.watson = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      options = {
        date_format = "%Y-%m-%d";
        reverse_log = true;
        stop_on_restart = true;
        stop_on_start = true;
      };
    };
  };
}
