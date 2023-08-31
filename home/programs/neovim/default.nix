{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    defaultEditor = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      lua-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.eslint
      nodePackages.prettier
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vim-language-server
      nodePackages.yaml-language-server
      rnix-lsp
      stylua
    ];
  };
}
