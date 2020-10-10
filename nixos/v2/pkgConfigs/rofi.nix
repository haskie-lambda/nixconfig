{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    width = null;
    lines = null;
    borderWidth = 0;
    rowHeight = 1;
    padding = null;
    scrollbar = false;
    terminal = "kitty";
    location = "center";
    #plugins = with pkgs; [
    #  rofi-calc
    #];
  };
}
