{ config, lib, pkgs, ... }:

{
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };
  };
}
