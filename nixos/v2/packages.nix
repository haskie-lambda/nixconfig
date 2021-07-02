pkgs:
with pkgs; [
  #system
  wget
  curl
  vim
  htop
  git
  ghostscript
  xclip
  home-manager
  protonvpn-cli #openvpn<defunct> bug
  tree
  unrar
  unzip
  wally-cli
  tdns-cli
  udisks
  lsof
  cowsay

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
  python3
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
  pandoc
  texlive.combined.scheme-full
  skype

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
  stylish-haskell

  # purescript for vim ide
  purescript  

  #collab
  teamviewer
  discord-canary
  signal-cli
  signal-desktop

  android-studio

  # uni
  virtualbox

  sshfs
]
