{ pkgs, ... }:
{
  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    enable = true;
    layout = "us";
#    startDbusSession = true;
    windowManager.i3 = {
      enable = true; 
      extraPackages = with pkgs; [
        rofi
        i3status
        i3lock-fancy
      ];
    };

    displayManager.defaultSession = "none+i3";
    desktopManager.xterm.enable = false;

    synaptics = {
      enable = true;
      twoFingerScroll = true;
      palmDetect = true;
    };

    #extraDisplaySettings = ''Visual GrayScale'';
    #extraDisplaySettings =
    #  ''Depth 1'';
  };

}
