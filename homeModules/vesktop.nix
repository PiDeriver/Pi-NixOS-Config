{ ... }: 
{
  programs.vesktop = {
    enable = true;
    vencord.settings ={
      #enabledThemes = ../theme/ClearVision-v7-BetterDiscord.theme.css;
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
