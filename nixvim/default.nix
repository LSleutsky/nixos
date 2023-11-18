{ config, lib, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
		enableMan = true;
		vimAlias = true;
    colorschemes.catppuccin = {
      enable = true;
      background.dark = "mocha";
      flavour = "mocha";
      terminalColors = true;
      integrations = {
        gitsigns = true;
        native_lsp.enabled = true;
        navic.enabled = true;
        nvimtree = true;
        telescope.enabled = true;
        treesitter = true;
        treesitter_context = true;
        ts_rainbow2 = true;
        illuminate = {
          enabled = true;
          lsp = true;
        };
        indent_blankline = {
          enabled = true;
          colored_indent_levels = true;
        };
      };
      styles = {
        booleans = ["bold" "italic"];
        conditionals = ["bold"];
        functions = ["bold"];
        keywords = ["italic"];
        loops = ["bold"];
        operators = ["bold"];
        properties = ["italic"];
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
      treesitter-context.enable = true;
      ts-autotag.enable = true;
      lualine = {
        enable = true;
        iconsEnabled = true;
        theme = "catppuccin";
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch" "diff" "diagnostics"];
          lualine_c = ["filename"];
          lualine_x = ["fileformat" "filetype"];
          lualine_y = ["progress"];
          lualine_z = ["location"];
        };
      };
			navic = {
				enable = true;
				highlight = true;
        lsp.autoAttach =  true;
			};
      nvim-autopairs = {
        enable = true;
        enableAfterQuote = true;
        enableBracketInQuote = true;
        enableCheckBracketLine = false;
        enableMoveright = true;
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
      treesitter = {
        enable = true;
        incrementalSelection.enable = true;
        indent = true;
        nixGrammars = true;
        nixvimInjections = true;
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
