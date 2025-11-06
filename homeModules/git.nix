{ ... }: 
{
  programs.git = {
    enable = true;
    settings = {
      user = {
	name = "PiDeriver";
        email = "pideriver@gmail.com";
      };
    };
  };
}
