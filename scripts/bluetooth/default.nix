{ config, lib, pkgs, ... }:

let
  bluetooth_toggle = pkgs.writeShellScriptBin "bluetooth_toggle" ''
    bluetooth toggle
  '';
in {
  environment.systemPackages = with pkgs; [
    bluetooth_toggle
  ];
}
