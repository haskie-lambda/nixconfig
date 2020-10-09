{ ... }:
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    };
    shellAliases = {
      xclip = ''xclip -selection c'';
      fix-audio = ''alsactl restore'';
    };

#    ohMyZsh = {
#      enable  = true;
#      plugins = [ "git" "man" ];
#      theme = "agnoster";
#    };
  };
}
