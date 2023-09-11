{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    location = "center";
  };
}
