{ ... }:

let style = import ../style.nix;

in {
  programs.kitty = {
    enable = true;
    font.name = style.font-term + " " + toString style.font-size;
  };
}
