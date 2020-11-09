{ config, pkgs, ... }:

{ 
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    loader.grub.device = "/dev/sda";
    initrd.checkJournalingFS = false;
  };

  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.amd.updateMicrocode = true;
  security.rngd.enable = false;

  networking = {
    hostName = "USERNAME";
    useDHCP = false;
    interfaces.enc33.useDHCP = true;
    networkmanager.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "Europe/Vienna";

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  imports = [
    ./audio.nix
  ];

  powerManagement.resumeCommands = "
    echo 1 > '/sys/bus/pci/devices/0000:09:00.3/remove' \n
    echo 1 > '/sys/bus/pci/rescan'\n
    ";

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  users.users.USERNAME = {
    isNormalUser = true;
    home = "/home/USERNAME";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networking" "wheel" "audio" "jackaudio" ];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
    extraRules = [
      { users = [ "USERNAME" ];
        commands = [ 
          { command = "/run/current-system/sw/bin/protonvpn"; 
            options = [ "NOPASSWD" ]; }
          #{ command = "nmcli";
          #  options = [ "NOPASSWD" "SETENV" ]; }
        ];
      }
    ];  
  };

  system.stateVersion = "20.03";

  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/1 * * * *  USERNAME protonvpn s | grep Server | sed -e 's/Server: *//' > /home/USERNAME/.config/i3status/vpnc"
    ];
  };

  systemd.user = {
    #timers.psc-timer = {
    #  wantedBy = [ "timers.target" ];
    #  partOf = [ "psc-updater.service" ];
    #  timerConfig.OnCalendar = "*-*-* *:*:*";
    #};

    services.psc-updater = {
      description = "pscircle updater";
      serviceConfig = {

ExecStart = "${pkgs.bash}/bin/bash -c \"while true; do ${pkgs.pscircle}/bin/pscircle --output-width=1920 --output-height=1080 --tree-radius-increment=110,180 --tree-center=-105:-56 --tree-font-size=12 --dot-radius=4 --cpulist-center=550:-200 --memlist-center=560:200 --background-image=/home/USERNAME/media/wallpaper/nix_nord.png --background-image-scale=1.12 --dot-color-min=88C0D0 --dot-color-max=5E81AC --link-width=1.5 --link-convexity=0.8; sleep 0.2; done\"";

      };
      wantedBy = [ "default.target" ];
      enable = true;
    };
  };
}
