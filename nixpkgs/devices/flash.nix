{ pkgs, ... }: {

  imports = [
    ../desktops/i3.nix
    ../programs/firefox.nix
  ];

  #home.packages = import ../packages.nix pkgs;

  home.keyboard.layout = "us";

  programs.git = {
    enable = true;
    userName = "faeblDevelopment";
    userEmail = "faebl.taylor@pm.me";
    extraConfig.core.editor = "vim";
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };
  
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-repeat
      vim-surround
      vim-commentary
      haskell-vim
      vim-nix
      nerdtree
      #vimtex
    ];
    extraConfig = import ../vimrc;
  };

  # programs.emacs = {
  #   enable = true;
  #   extraPackages = epkgs: [
  #     pkgs.lilypond
  #   ];
  # };

  #home.file = let
  #  repo = pkgs.fetchgit {
  #    url = "https://gitlab.com/luc65r/emacs";
  #    sha256 = "1sd9jl51kb8whxq62mbdqg88c4275cnn97xxkqrdcx3rnp9j8ppg";
  #  };
  #in {
  #  ".emacs.d/init.el".source = repo + "/init.el";
  #  ".emacs.d/configuration.org".source = repo + "/configuration.org";
  #};

  # home.file.".emacs.d/configuration.org".source = pkgs.fetchgit {
  #   url = "https://gitlab.com/luc65r/emacs";
  #   sha256 = "0fqv953gybwjnyk5qjzp217pj2rpwiac85xvlirl61mysfccq1x0";
  # } + "/configuration.org";

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    };
    shellAliases = {
      _git2ssh = ''git remote set-url origin $(git remote -v | grep "^origin" | tr "\t" "\n" | tr " " "\n" | head -n 2 | tail -n 1 | sed -r "s|https*://([a-z0-9.]+)/(.+)|git@\1:\2|g")'';
    };
  };

  # programs.obs-studio = {
  #   enable = true;
  # };

  # programs.mpv = {
  #   enable = true;
  #   config = {
  #     ytdl-format = "bestvideo+bestaudio";
  #     hwdec = "auto";
  #   };
  # };

  home.sessionVariables = {
    EDITOR = "vim";
    SHELL = "zsh";
  };

  # services.mpd = {
  #   enable = true;
  #   musicDirectory = "/home/lucas/Musique";
  #   network = {
  #     listenAddress = "any";
  #   };
  #   extraConfig = ''
  #     audio_output {
  #       type "pulse"
  #       name "pulse audio"
  #     }
  #   '';
  # };
  # 
  # programs.beets = {
  #   enable = true;
  #   package = (pkgs.beets.override {
  #     enableAlternatives = true;
  #     enableCheck = true;
  #     enableCopyArtifacts = true;
  #   });
  #   settings = {
  #     directory = "~/Musique";
  #     plugins = [ "lyrics" "duplicates" "fetchart" ];
  #     ui.color = true;
  #     import = {
  #       move = true;
  #     };
  #     lyrics = {
  #       auto = true;
  #     };
  #   };
  # };

  # home.file.".blender/dracula.xml".source = pkgs.fetchFromGitHub {
  #   owner = "dracula";
  #   repo = "blender";
  #   rev = "624a3c5065e57a2f1dc160b6e827ccb7c12f255e";
  #   sha256 = "09ryljn9prq109qwh112jivl1jvn6x6aw99rgxnlkdpas8hrdhi9";
  # } + "/dracula.xml";

  home.file.".local/share/TelegramDesktop/dracula.tdesktop-theme".source = pkgs.fetchurl {
    url = "https://github.com/dracula/telegram/releases/download/v0.1.2/dracula-theme.tdesktop-theme";
    sha256 = "03xbr5klxnzmrqqz5mvbwsin4w8v5kdnm177lnvfrljmcn7yann2";
  };

  home.file.".steam/skins/Dracula".source = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "steam";
    rev = "9c54484d1b367bc01189a2d1dc2132a466fb68b3";
    sha256 = "028n3icqx4ry5jfhwrq2dpkqdm6ab9wclbkkrm8x0v0nlnnfrayh";
  };

  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "zathura.desktop" ];
        "image/png" = [ "sxiv.desktop" "feh.desktop" ];
        "image/jpeg" = [ "sxiv.desktop" "feh.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/ftp" = [ "firefox.desktop" ];
        "x-scheme-handler/chrome" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "application/x-extension-htm" = [ "firefox.desktop" ];
        "application/x-extension-html" = [ "firefox.desktop" ];
        "application/x-extension-shtml" = [ "firefox.desktop" ];
        "application/xhtml+xml" = [ "firefox.desktop" ];
        "application/x-extension-xhtml" = [ "firefox.desktop" ];
        "application/x-extension-xht" = [ "firefox.desktop" ];
      };
      #applications.added = {
      #};
    };
  };
}
