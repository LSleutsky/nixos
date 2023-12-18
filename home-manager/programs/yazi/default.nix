{ config, lib, inputs, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.yazi;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
