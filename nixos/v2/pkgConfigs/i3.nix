{ pkgs, config, lib, ... }:

let mod = "Mod4"; 
    fix-audio = ''pactl load-module module-jack-sink channels=2; pactl load-module module-jack-source channels=1'';
    fix-wallpaper = ''pscircle; systemctl --user restart psc-updater'';
in
    {

        xsession.windowManager.i3 = {
            enable = true; 

            config = rec {

                startup = [
                    { command = "recollindex -m"; always = true; notification = false; }
                    { command = fix-wallpaper; always = true; notification = false; }
                    { command = fix-audio; always = true; notification = false; }
                    { command = "sudo protonvpn r"; always = true; notification = false; }
                ];

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
                    "${mod}+p" = "exec rofi -modi find:/etc/nixos/v2/pkgConfigs/search-recoll-dmenu.sh";
                    "${mod}+x" = "exec screenshot";
                    "${mod}+c" = "exec flameshot gui";
                    "${mod}+l" = "exec i3lock-fancy -t Authenticate && sudo protonvpn r";

                    "XF86AudioMute" = "exec amixer set Master toggle";
                    "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
                    "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";

                    "XF86MonBrightnessUp" = "exec xbacklight -inc 10";
                    "XF86MonBrightnessDown" = "exec xbacklight -dec 10";

                };

            };

        };

    }
