{ pkgs, ... }:

let style = import ../style.nix;

in {
  programs.rofi = {
    enable = true;
    width = null;
    lines = null;
    borderWidth = 0;
    rowHeight = 1;
    padding = null;
    font = style.font + " " + toString style.font-size;
    scrollbar = false;
    terminal = "alacritty";
    location = "center";
    colors = with style.color; {
      window = {
        inherit background;
        border = background;
        separator = selection;
      };
      rows = {
        normal = {
          inherit background foreground;
          backgroundAlt = background;
          highlight = {
            background = selection;
            inherit foreground;
          };
        };
      };
    };
    plugins = with pkgs; [
      rofi-calc
    ];
  };
}
