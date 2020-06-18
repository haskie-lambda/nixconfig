{ pkgs, ... }:
{
  # UI
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  services.xserver = {
    enable = true;
    layout = "us";

    displayManager = {
      #defaultSession = "none+i3";
    };

    desktopManager = {
      xterm.enable = false;
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu i3status i3lock
     ];
     package = pkgs.i3-gaps;
    };
  };

}
