{ pkgs, config, lib, ... }:

let mod = "Mod4";
in
{

  xsession.windowManager.i3 = {
    enable = true; 

    config = rec {
      modifier = mod;
      bars = [ 
      	{ 
	  position = "bottom";
	  statusCommand = "i3status";
         }
       ];

      keybindings = pkgs.lib.mkOptionDefault {
        "${mod}+Return" = "exec kitty";
        "${mod}+q" = "kill";
        "${mod}+d" = "exec rofi -modi drun -show drun";
	"${mod}+x" = "exec screenshot";
	"${mod}+l" = "exec i3lock";

        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
      };
      
    };

  };

}
