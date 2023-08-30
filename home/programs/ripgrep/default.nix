{ config, lib, pkgs, ... }:

{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--hidden"
      "--smart-case"
      "--glob=!.git/*"
      "--glob=!{**/node_modules/**, node_modules/**, node_modules}"
      "--glob=!package-lock.json"
    ];
  };
}
