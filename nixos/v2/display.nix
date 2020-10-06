{ pkgs, ... }:
{
  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    enable = true;
    layout = "us";
    
    displayManager.defaultSession = "none+i3";
    desktopManager.xterm.enable = false;
  };
}
