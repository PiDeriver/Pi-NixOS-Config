{userSettings, systemSettings, ... }: 
{
  environment.etc."xdg/hypr/variables.lua".text = ''
    mod = "SUPER"
    hostName = "${systemSettings.hostName}";
    terminal = "${userSettings.terminal}";
    browser = "${userSettings.browser}";
  '';
} 
