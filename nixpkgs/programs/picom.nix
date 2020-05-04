{ ... }:

{
  services.picom = {
    enable = true;
    blur = true;
    activeOpacity = "1";
    inactiveOpacity = "1";
    menuOpacity = "0.9";
    opacityRule = [
      "90:class_g = 'Polybar'"
      "90:class_g = 'Alacritty'"
      "90:class_g = 'Rofi'"
      "90:class_g = 'Zathura'"
      "90:class_g = 'Vim'"
    ];
    backend = "xrender";
    extraOptions = ''
      blur-kern = "7x7box";
    '';
  };
}
