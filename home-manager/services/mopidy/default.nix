{ config, lib, pkgs, ... }:

{
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-ytmusic
    ];
  };
}
