{ config, lib, pkgs, ... }:

let
  rofi_toggle = pkgs.writeShellScriptBin "rofi_toggle" ''
    rofi -show drun
  '';
in {
  environment.systemPackages = with pkgs; [
    rofi_toggle
  ];
}
