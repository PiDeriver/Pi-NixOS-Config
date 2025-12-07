{ pkgs, ... }:
{
  environment.sessionVariables = {
    HYPRCURSOR_THEME = "Chiharu";
    HYPRCURSOR_SIZE = 12;
    XCURSOR_THEME = "Chiharu";
    XCURSOR_SIZE = 12;
    # as a list makes this append to instead of overwrite.
    XCURSOR_PATH = ["$HOME/.icons"];
  };
}
