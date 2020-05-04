{ pkgs, ... }:

let style = import ../style.nix;

in {
  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
      mpdSupport = true;
    };

    script = "polybar -q -r top &";

    config = {
      "global/wm" = {
        margin-bottom = 0;
        margin-top = 0;
      };

      "bar/top" = {
        bottom = false;
        wm-restack = "none";
        fixed-center = true;
        width = "100%";
        height = 20;
        offset-x = 0;
        offset-y = 0;
        
        line-size = 2;
        line-color = style.color.selection;

        padding-left = 0;
        padding-right = 2;

        module-margin-left = 2;
        module-margin-right = 2;

        font-0 = "${style.font}:size=${toString style.font-size};0";
        font-1 = "${style.font-icons}:size=${toString style.font-size};0";

        inherit (style.color) background foreground;
        border-color = style.color.background;
        border-top-size = 4;

        modules-left = "i3";
        modules-center = "mpd";
        modules-right = "cpu temp ram net volume date";

        tray-position = "right";
        tray-padding = 0;
      };

      "module/i3" = {
        type = "internal/i3";
        formal = "<label-state> <label-mode>";
        index-sort = true;
        enable-click = true;
        enable-scroll = false;
        strip-wsnumbers = true;

        ws-icon-0 = "1;";
        ws-icon-1 = "2;";
        ws-icon-2 = "3;";
        ws-icon-3 = "4;";
        ws-icon-4 = "5;";
        ws-icon-5 = "6;";
        ws-icon-6 = "7;";
        ws-icon-7 = "8;";
        ws-icon-8 = "9;";
        ws-icon-9 = "10;";

        label-mode-padding = 2;
        label-mode-foreground = style.color.foreground;
        label-mode-background = style.color.background;

        label-focused = "%icon%";
        label-focused-foreground = style.color.foreground;
        label-focused-background = style.color.background;
        label-focused-underline = style.color.cyan;
        label-focused-padding = 1;

        label-unfocused = "%icon%";
        label-unfocused-foreground = style.color.foreground;
        label-unfocused-background = style.color.background;
        label-unfocused-underline = style.color.selection;
        label-unfocused-padding = 1;

        label-visible = "%icon%";
        label-visible-foreground = style.color.foreground;
        label-visible-background = style.color.background;
        label-visible-underline = style.color.selection;
        label-visible-padding = 1;

        label-urgent = "%icon%";
        label-urgent-foreground = style.color.foreground;
        label-urgent-background = style.color.background;
        label-urgent-underline = style.color.magenta;
        label-urgent-padding = 1;
      };

      "module/date" = {
        type = "internal/date";
        date = " %H:%M";
        interval = 10;
        format-underline = style.color.magenta;
      };

      "module/volume" = {
        type = "internal/volume";
        format-volume = "<ramp-volume> <label-volume>";
        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
        format-muted = "<label-muted>";
        label-muted = "";
        format-volume-underline = style.color.cyan;
        format-muted-underline = style.color.red;
      };

      "module/cpu" = {
        type = "internal/cpu";
        label = " %percentage%%";
        interval = 1;
        format-underline = style.color.blue;
      };
      
      "module/temp" = {
        type = "internal/temperature";
        hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon0/temp1_input";
        label = "󰃮 %temperature-c%";
        label-warn = "󰃮 %temperature-c%";
        warn-temperature = 50;
        interval = 1;
        format-underline = style.color.cyan;
        format-warn-underline = style.color.red;
      };

      "module/ram" = {
        type = "internal/memory";
        label = " %gb_used%/%gb_total%";
        interval = 1;
        format-underline = style.color.green;
      };

      "module/net" = {
        type = "internal/network";
        interface = "enp4s0";
        label-connected = " %upspeed%   %downspeed%";
        label-disconnected = "";
        interval = 1;
        format-connected-underline = style.color.yellow;
        format-disconnected-underline = style.color.white;
      };

      "module/mpd" = {
        type = "internal/mpd";
        host = "127.0.0.1";
        port = "6600";
        format-online = "<label-song>";
        label-song = "%artist% - %title%";
        interval = 1;
        format-paused-underline = style.color.selection;
        format-playing-underline = style.color.yellow;
      };

      # "module/vpn" = {
      # ...
      # }
    };
  };
}
