{ pkgs, ... }:

{

  services.xserver.windowManager.i3 = {
    enable = true; 
    extraPackages = with pkgs; [
      rofi
      i3status
      i3lock
    ];
#    package = pkgs.i3-gaps;
  
    config = rec {
      modifier = "Mod4";
      bars = [];
      window.border = 0;
      gaps = {
        inner = 10; 
        outer = 0;
        smartGaps = true;
      };

      keybindings = pkgs.lib.mkOptionDefault {
        "${modifier}+Return" = "exec kitty";
        "${modifier}+q" = "kill";
        "${modifier}+d" = "exec rofi -modi drun -show drun";
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
      };
 
    };

  };
}
