{ config, lib, pkgs, ... }:

{
  programs.cava = {
    enable = true;
    package = pkgs.cava;
    settings = {
      general = {
        autosens = 1;
        overshoot = 0;
        bars = 0;
        bar_width = 2.0;
        bar_spacing = 1.0;
      };
      input = {
        method = "pipewire";
        channels = "mono";
      };
      color = {
        gradient = 1;
        gradient_color_1 = "'#9ece6a'";
        gradient_color_2 = "'#73daca'";
        gradient_color_3 = "'#7dcfff'";
        gradient_color_4 = "'#7aa2f7'";
        gradient_color_5 = "'#bb9af7'";
      };
      smoothing = {
        waves = 0;
        gravity = 100;
      };
    };
  };
}
