{ ... }:

let style = import ../style.nix;

in {
  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      font = style.font + " " + toString style.font-size;
      default-fg = style.color.foreground;
      default-bg = style.color.background;
      recolor-darkcolor = style.color.foreground;
      recolor-lightcolor = style.color.background;
    };
  };
}
