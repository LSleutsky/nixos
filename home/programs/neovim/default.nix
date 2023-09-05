{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraPackages = with pkgs; [
      lua-language-server
      nodePackages_latest.dockerfile-language-server-nodejs
      nodePackages_latest.eslint
      nodePackages_latest.prettier
      nodePackages_latest.typescript
      nodePackages_latest.typescript-language-server
      nodePackages_latest.vim-language-server
      nodePackages_latest.yaml-language-server
      rnix-lsp
      stylua
    ];
  };
}
