{ config, lib, pkgs, ... }:

{
  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withNerdIcons = true; });
    extraPackages = with pkgs; [ ffmpegthumbnailer mediainfo ];
    bookmarks = {
      c = "~/.config";
      d = "~/Documents";
      D = "~/Downloads";
      f = "~/repos/dotfiles";
      n = "~/nixos";
      p = "~/Pictures";
      v = "~/Videos";
    };
  };
}
