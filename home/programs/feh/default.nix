{ config, lib, pkgs, ... }:

{
  programs.feh = {
    enable = true;
    keybindings = {
      flip = "v";
      mirror = "h";
      next_img = [ "l" "Right" ];
      prev_img = [ "h" "Left" ];
      toggle_filenames = "f";
      toggle_fullscreen = "F";
      toggle_pause = "p";
      zoom_in = "plus";
      zoom_out = "minus";
    };
  };
}
