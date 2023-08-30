{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    defaultEditor = true;
    vimdiffAlias = true;
    withNodeJs = true;
  };
}
