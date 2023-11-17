{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    viAlias = true;
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
      nodePackages_latest.tailwindcss
      nodePackages_latest.typescript
      nodePackages_latest.typescript-language-server
      nodePackages_latest.vim-language-server
      nodePackages_latest.yaml-language-server
      rnix-lsp
      stylua
    ];
    plugins = with pkgs.vimPlugins; [
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup({
            options = { theme = 'tokyonight-nvim' },
            sections = {
              lualine_a = { 'mode' },
              lualine_b = { 'branch', 'diff' },
              lualine_c = { 'filename' },
              lualine_x = { 'encoding', 'filetype' },
              lualine_y = { 'progress' },
              lualine_z = { 'location' }
            }
          })
        '';
      }
    ];
    extraLuaConfig = ''
      vim.opt.incsearch = true
      vim.opt.number = true
      vim.opt.numberwidth = 2
      vim.opt.relativenumber = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.expandtab = true
      vim.opt.autoindent = true
      vim.opt.smartindent = true
      vim.opt.shiftwidth = 2
      vim.opt.softtabstop = 2
      vim.opt.tabstop = 2
      vim.opt.signcolumn = "yes"
      vim.opt.termguicolors = true
      vim.opt.mouse = "a"
      vim.opt.swapfile = false
    '';
  };
}
