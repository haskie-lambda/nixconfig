{ pkgs, ... }:

let style = import ../style.nix;

in {
  imports = [
    # Terminal emulator
    ../programs/alacritty.nix
    ../programs/kitty.nix

    # Compositor
    ../programs/picom.nix

    # Bar
    ../programs/polybar.nix

    # Notifications
    ../programs/dunst.nix

    # PDF viewer
    ../programs/zathura.nix

    # Application launcher
    ../programs/rofi.nix
  ];

  xsession = {
    enable = true;

    pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 16;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;

      config = rec {
        fonts = with style; [
          (font-icons + " " + toString font-size)
          (font + " " + toString font-size)
        ];
        modifier = "Mod4";
        bars = [];
        window.border = 0;
        gaps = {
          inner = 10;
          outer = 0;
          smartGaps = true;
        };

        colors = with style.color; {
          #focusedInactive = ;
          #urgent = ;
          #placeholder = ;
          background = background;
          focused = {
            border = background;
            background = background;
            text = foreground;
            indicator = red;
            childBorder = cyan;
          };
          unfocused = {
            border = background;
            background = background;
            text = selection;
            indicator = green;
            childBorder = selection;
          };
        };

        keybindings = pkgs.lib.mkOptionDefault {
          "${modifier}+Return" = "exec alacritty";
          "${modifier}+q" = "kill";
          "${modifier}+d" = "exec rofi -modi drun -show drun";
          "XF86AudioMute" = "exec amixer set Master toggle";
          "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
          "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
          "XF86AudioPause" = "exec mpc toggle";
          "XF86AudioPrev" = "exec mpc prev";
          "XF86AudioNext" = "exec mpc next";
        };

        assigns = {
          "2" = [
            {class = "Firefox";}
          ];
          "5" = [
            {class = "libreoffice$";}
          ];
          "8" = [
            {class = "discord";}
            {class = "TelegramDesktop";}
          ];
          "9" = [
            {class = "PCSX2";}
          ];
          "10" = [
            {class = "Steam";}
          ];
        };

        floating.criteria = [
          {"class" = "Steam";}
          {"class" = "PCSX2";}
        ];

        startup = [
          { command = "systemctl --user restart polybar"; always = true; notification = false; }
        ];
      };
    };
  };

  services.random-background = {
    enable = true;
    imageDirectory = "%h/Documents/Wallpapers";
  };
}
