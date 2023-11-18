{ config, lib, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
		enableMan = true;
		vimAlias = true;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      integrations = {
        gitsigns = true;
        illuminate = true;
        navic.enabled = true;
      };
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
				mode = "n";
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
      lualine = {
        enable = true;
        iconsEnabled = true;
        theme = "tokyonight";
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" "diff" "diagnostics" ];
          lualine_c = [ "filename" ];
          lualine_x = [ "fileformat" "filetype" ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };
			navic = {
				enable = true;
				highlight = true;
        lsp.autoAttach =  true;
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
