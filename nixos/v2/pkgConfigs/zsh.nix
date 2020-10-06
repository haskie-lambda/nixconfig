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
    };
    ohMyZsh = {
      enable  = true;
      plugins = [ "git" "man" ];
      theme = "agnoster";
    };
  };
}
