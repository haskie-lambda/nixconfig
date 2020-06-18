{ pkgs, ... }:
{
  # UI
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver = {
    enable = true;
    layout = "us";

    desktopManager = {
      xterm.enable = false;
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
