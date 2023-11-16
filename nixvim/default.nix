{ config, lib, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
		enableMan = true;
		vimAlias = true;
    colorschemes.tokyonight = {
      enable = true;
      lualineBold = true;
      style = "night";
    };
    options = {
			incsearch = true;
      number = true;
      numberwidth = 2;
      relativenumber = true;
      ignorecase = true;
      smartcase = true;
      expandtab = true;
      autoindent = true;
      preserveindent = true;
			smartindent = true;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
      signcolumn = "yes";
      termguicolors = true;
      mouse = "a";
      swapfile = false;
    };
		keymaps = [
			{
				mode = "n";
				key = "<C-s>";
				action = ":w<CR>";
			}
			{
				mode = [ "n" "v" ];
				key = "-";
				action = ":qa!<CR>";
			}
			{
				key = "<esc>";
				action = ":noh<CR>";
				options = {
					silent = true;
				};
			}
			{
				mode = "v";
				key = ">gv";
				action = ">";
			}
			{
				mode = "v";
				key = "<gv";
				action = "<";
			}
			{
				mode = "i";
				key = "<C-s>";
				action = "<esc>:w<CR>";
			}
		];
		plugins = {
			cursorline.enable = true;
			illuminate.enable = true;
			indent-blankline.enable = true;
			nix.enable = true;
			nix-develop.enable = true;
			surround.enable = true;
			navic = {
				enable = true;
				highlight = true;
			};
			nvim-colorizer = {
				enable = true;
				userDefaultOptions = {
					css = true;
					css_fn = true;
					hsl_fn = true;
					names = true;
					rgb_fn = true;
					tailwind = true;
				};
			};
			vim-matchup = {
				enable = true;
				enableSurround = true;
				textObj.enable = true;
				treesitterIntegration.enable = true;
				matchParen = {
					enable = true;
					deffered.enable = true;
					hiSurroundAlways = true;
				};
			};
		};
  };
}
