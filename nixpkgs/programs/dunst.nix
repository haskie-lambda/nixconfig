{ ... }:

let style = import ../style.nix;

in {
  services.dunst = {
    enable = true;
    #iconTheme = pkgs.hicolor-icon-theme;
    settings = {
      global = {
        geometry = "300x5-30+50";
        font = style.font + " " + toString style.font-size;
        frame_color = style.color.background;
      };
      urgency_low = with style.color; {
        inherit background foreground;
        timeout = 5;
      };
      urgency_normal = with style.color; {
        inherit background foreground;
        timeout = 10;
      };
      urgency_critical = with style.color; {
        inherit background;
        foreground = red;
        timeout = 5;
      };
    };
  };
}
