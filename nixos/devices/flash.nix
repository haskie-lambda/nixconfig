{ config, pkgs, ... }:

{
  imports = [
    ../desktops/i3.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    
    #for virtualbox
    loader.grub.device = "/dev/sda";
    initrd.checkJournalingFS = false;
    # ensd virutualbox
  };

  

  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.amd.updateMicrocode = true;
  security.rngd.enable = false;
#  nix = {
#    maxJobs = 1;
#    buildCores = 12;
#    binaryCaches = [
#      "https://meros.cachix.org"
#    ];
#    binaryCachePublicKeys = [
#      "meros.cachix.org-1:Zp80aqT/HTZgS8FybS7UpDv8IPo2jsbCluiNQ1PbouQ="
#    ];
#  };

#  zramSwap = {
#    enable = true;
#    algorithm = "zstd";
#  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
#    useDHCP = false;
#    interfaces.enp4s0 = {
#      ipv4.addresses = [
#        { address = "192.168.0.10"; prefixLength = 24; }
#      ];
#      ipv6.addresses = [
#        { address = "2a01:cb19:86ed:f600::10"; prefixLength = 56; }
#      ];
#    };
#    defaultGateway = { address = "192.168.0.1"; interface = "enp4s0"; };
#    defaultGateway6 = { address = "2a01:cb19:86ed:f600:46a6:1eff:fe80:c516"; interface = "enp4s0"; };
#    nameservers = [ "84.200.69.80" "84.200.70.40" "2001:1608:10:25::1c04:b12f" "2001:1608:10:25::9249:d69b" ];
    hostName = "faebl";
    wireless.enable = true;
    useDHCP = false;
    interfaces.ens33.useDHCP = true;
  };


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "de_AT.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    #keyMap = "en-latin1";
  };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # List packages installed in system profile.
  environment.systemPackages = import ../packages.nix pkgs;
  nixpkgs.config.allowUnfree = true;

  fonts = import ../fonts.nix pkgs;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # programs.fuse.userAllowOther = true;

  #programs.npm = {
  #  enable = true;
  #  npmrc = ''
  #    prefix = ''${HOME}/.npm
  #    color = true;
  #  '';
  #};

  # programs.adb.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  #services.system-config-printer.enable = true;
  #services.printing = {
  #  enable = true;
  #  drivers = with pkgs; [
  #    gutenprint
  #    gutenprintBin
  #    cups-googlecloudprint
  #  ];
  #  browsing = true;
  #  defaultShared = true;
  #  extraConf = ''
  #    BrowseDNSSDSubTypes _cups,_print
  #    BrowseLocalProtocols all
  #    BrowseRemoteProtocols all
  #    CreateIPPPrinterQueues All
  #  '';
  #  browsedConf = ''
  #    BrowseDNSSDSubTypes _cups,_print
  #    BrowseLocalProtocols all
  #    BrowseRemoteProtocols all
  #    CreateIPPPrinterQueues All
  #
  #    BrowseProtocols all
  #  '';
  #};

  #hardware.sane.enable = true;

  #hardware.wooting.enable = true;

  # services.avahi = {
  #   enable = true;
  #   nssmdns = true;
  # };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraClientConf = "autospawn=yes\n";
    #extraConfig = ''
    #  load-module module-equalizer-sink
    #  load-module module-dbus-protocol
    #'';
  };

  # Fix a bug : no sound after suspend to RAM
  powerManagement.resumeCommands = "
    echo 1 > '/sys/bus/pci/devices/0000:09:00.3/remove' \n
    echo 1 > '/sys/bus/pci/rescan' \n
  ";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "en";
    #xkbOptions = "eurosign:e";

  # Enable proprietary NVIDIA drivers
  #  videoDrivers = [ "nvidia" ];

  # Enable touchpad support.
    libinput = {
      enable = true;
      accelProfile = "flat";
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.faebl = {
    isNormalUser = true;
    home = "/home/faebl";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networking" ]; # Enable ‘sudo’ for the user.
  };
  
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?

}
