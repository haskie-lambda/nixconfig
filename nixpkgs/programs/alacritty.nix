{ ... }:

let style = import ../style.nix;

in {
  programs.alacritty = {
    enable = true;
    settings = {
      cursor.style = "Beam";
      window.padding = { x = 5; y = 5; };
      colors = with style.color; {
        primary = {
          inherit background foreground;
        };
        cursor = {
          text = selection;
          cursor = foreground;
        };
        normal = {
          inherit black red green yellow blue magenta cyan white;
        };
        bright = {
          black = bright-black;
          red = bright-red;
          green = bright-green;
          yellow = bright-yellow;
          blue = bright-blue;
          magenta = bright-magenta;
          cyan = bright-cyan;
          white = bright-white;
        };
        dim = {
          black = dim-black;
          red = dim-red;
          green = dim-green;
          yellow = dim-yellow;
          blue = dim-blue;
          magenta = dim-magenta;
          cyan = dim-cyan;
          white = dim-white;
        };
      };
      font = {
        size = style.font-size;
        normal = {
          family = style.font-fixed;
          style = "Regular";
        };
        bold = {
          family = style.font-fixed;
          style = "Bold";
        };
        italic = {
          family = style.font-fixed;
          style = "Italic";
        };
        bold_italic = {
          family = style.font-fixed;
          style = "Bold Italic";
        };
      };
    };
  };
}
