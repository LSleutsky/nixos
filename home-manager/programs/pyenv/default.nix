 { config, lib, pkgs, ... }:

 {
   programs.pyenv = {
     enable = true;
     enableBashIntegration = true;
     enableZshIntegration = true;
   };
 }
