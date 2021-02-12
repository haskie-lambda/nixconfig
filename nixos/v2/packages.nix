pkgs: with pkgs; [
  #system
  wget
  curl
  vim
  htop
  git
  ghostscript
  xclip
  home-manager
  protonvpn-cli
  tree
  unrar
  unzip
  wally-cli
  tdns-cli

  # nix-autobahn
  fzf
  nix-index
  # wonderdraft
  xorg.libX11

  #rice
  zsh
  oh-my-zsh
  plotinus
  elvish
  rofi
  recoll
  polybar
  alacritty 
  dunst 
  kitty
  zathura
  nomacs
  inkscape
  pscircle
  xorg.xbacklight
  

  #media
  firefox 
  wine
  winetricks
  winePackages.fonts
  pulsemixer
  arandr
  chromium
  unzip
  lutris
  flameshot
  vlc
  steam

  #audio
  qjackctl
  ardour

  #haskell
  ghc
  zlib
  stack
  cabal2nix
  nix-prefetch-git
  cabal-install 
  vscode
  #https://jkuokkanen109157944.wordpress.com/2020/11/10/creating-a-haskell-development-environment-with-lsp-on-nixos/
  nodejs # For coc-nvim
  haskellPackages.haskell-language-server
  (neovim.override {
     configure = {
       packages.myPlugins = with pkgs.vimPlugins; {
         start = [ coc-nvim ];
         opt = [];
       };
     };
  })

  #collab
  teamviewer
  discord-canary
  signal-cli
  signal-desktop

  android-studio
]
