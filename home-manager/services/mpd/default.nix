{ config, lib, pkgs, ... }:

{
  services.mpd = {
    enable = true;
    package = pkgs.mpd;
    network.startWhenNeeded = true;
  };
}
