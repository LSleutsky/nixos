{ config, lib, pkgs, ... }:

let
  screenshot_area = pkgs.writeShellScriptBin "screenshot_area" ''
    grim -g "$(slurp)" ~/Screenshots/$(date '+%F+%T-screenshot-area').png
  '';

  screenshot_full = pkgs.writeShellScriptBin "screenshot_full" ''
    grim ~/Screenshots/$(date '+%F+%T-screenshot-full').png
  '';
in {
  environment.systemPackages = with pkgs; [
    screenshot_area
    screenshot_full
  ];
}
