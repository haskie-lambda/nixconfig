{ pkgs, ... }:

{ 
  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      enable_autio_bell = false;
      extraConfig = ''
        include /etc/nixos/v2/theme.conf
      '';
    };
  };
}
