{pkgs, ... }: 
{
  programs.java = {
    enable = true;
    package = pkgs.jdk.override {
      enableJavaFX = true;
      openjfx_jdk = pkgs.openjfx.override {
        featureVersion = "21";
      };
    };
  };
  home.packages = with pkgs; [
    portaudio
  ];
}
