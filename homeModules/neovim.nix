{ pkgs, ... }: 
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        extraPackages = with pkgs; [
          nil
          texlab
        ];
        keymaps = [
          # Disable the 'Q' key (often mapped to q:) in Normal mode to prevent accidental Command-line window opening
          {
            mode = "n";
            key = "Q";
            action = "<Nop>";
            silent = true;
          }
          # Explicitly disable the q: command mapping as well
          {
            mode = "n";
            key = "q:";
            action = "<Nop>";
            silent = true;
          }
        ];
        lazy.plugins = {
          "vimtex" = {
            package = pkgs.vimPlugins.vimtex;
            setupModule = "vimtex";
            cmd = ["Vimtex"];
          };
        };
        # autopairing of grouping characters
        autopairs.nvim-autopairs.enable = true;
        # status line
        statusline.lualine.enable = true;
        # search and picker utility
        telescope.enable = true;
        # autocomplete
        autocomplete.nvim-cmp.enable = true;
        # markdown preview


        # Language Server Protocol setup
        lsp = {
          enable = false;
          lspconfig.enable = true;
          servers = {
            # Use nil_ls for Nix files
            nil_ls = {
              enable = true;
            };
            texlab = {
              enable = true;
            };
          };
        };

        # Language configurations
#        languages = {
#          enableTreesitter = true;
#          nix = {
#            enable = true;
#            lsp.package = pkgs.nil;
#          };
/*          markdown = {
            enable = true;
            lsp.package = pkgs.marksman;
            extensions.markview-nvim = {
              enable = true;
            }; 
          };*/
#        };  
        # Clipboard configuration
        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
          registers = "unnamedplus";
        };
      }; 
    };
  };
}
