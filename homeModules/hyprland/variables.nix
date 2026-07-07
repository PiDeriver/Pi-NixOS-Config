{userSettings, systemSettings, ... }: 
{
  environment.etc."${config.xdg.configHome}/hypr/variables.lua".text = ''
    mod = "SUPER"
    hostName = "${systemSettings.hostName}";
    terminal = "${userSettings.terminal}";
    browser = "${userSettings.browser}";
  '';
} 
