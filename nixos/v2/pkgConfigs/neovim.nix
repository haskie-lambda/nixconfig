{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs; [
      haskell-vim
      vim-nix
      nerdtree
    ];
    extraConfig = import ../vimrc;
  };
}
