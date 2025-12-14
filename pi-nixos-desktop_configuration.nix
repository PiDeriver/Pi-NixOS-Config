{ ... }:
{
  imports = [
    ./common_configuration.nix
    
    nixModules/desktop-services.nix
    nixModules/steam.nix
  ];
}
