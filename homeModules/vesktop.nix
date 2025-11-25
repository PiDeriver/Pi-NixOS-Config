{ ... }: 
{
  stylix.targets = {
    vesktop.enable = false;
    vencord.enable = false;
  };

  programs.vesktop = {
    enable = true;
    vencord.themes = {
      #test = home/pideriver/.dotfiles/homeModules/vesktopTheme.css;
      #test = import ./vesktopcss.nix;
      test = import /home/pideriver/.dotfiles/homeModules/vesktopcss.nix; #This works!
      #test = import "$HOME/.dotfiles/homeModules/vesktopcss.nix";
    };
    vencord.settings ={
      enabledThemes = ["test.css"];
      plugins = {
        ChatInputButtonAPI = {
          enabled = true;
        };
        BlurNSFW = {
          enabled = true;
          blurAmount = 10;
        };
        FixYoutubeEmbeds = {
          enabled = true;
        };
        OnePingPerDM = {
          enabled = true;
          channelToAffect = "both_dms";
          allowMentions = true;
          allowEveryone = true;
        };
        SendTimestamps = {
          enabled = true;
          replaceMessageContents = true;
        };
        ShowConnections = {
          enabled = true;
          iconSize = 32;
          iconSpacing = 1;
        };
        SpotifyCrack = {
          enabled = true;
          noSpotifyAutoPause = true;
          keepSpotifyActivityOnIdle = true;
        };
        WebKeybinds = {
          enabled = true;
        };
        WebScreenShareFixes = {
          enabled = true;
        };
        YoutubeAdblock = {
          enabled = true;
        };
        VolumeBooster = {
          enabled = true;
          multiplier = 1;
        };
      };
    };
  };   
}
