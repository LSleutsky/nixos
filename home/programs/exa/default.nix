{ config, lib, pkgs, ... }:

{
  programs.exa = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
    extraOptions = [
      "--all"
        "--binary"
        "--group-directories-first"
        "--long"
    ];
  };
}
