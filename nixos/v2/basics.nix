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
    enableIPv6 = true;
    #interfaces.enc33.useDHCP = true;
    networkmanager.enable = true;
    extraHosts = "104.16.16.35 registry.npmjs.org";

    firewall.allowedTCPPortRanges =[
        { from = 8000; to = 9000; }
        { from = 18000; to = 20000; }
    ];
    firewall.allowedUDPPortRanges =[
        { from = 8000; to = 9000; }
        { from = 18000; to = 20000; }
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "Europe/Vienna";

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  imports = [
    <nix-ld/modules/nix-ld.nix>
    ./audio.nix
  ];

  powerManagement.resumeCommands = "
    echo 1 > '/sys/bus/pci/devices/0000:09:00.3/remove' \n
    echo 1 > '/sys/bus/pci/rescan'\n
    sudo protonvpn r
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

  system.stateVersion = "20.09";

  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/1 * * * *  USERNAME protonvpn s | grep Server | sed -e 's/Server: *//' > /home/USERNAME/.config/i3status/vpnc"
      "*/1 * * * *  USERNAME zsh /home/USERNAME/.config/i3status/timer_script"
    ];
  };

  services.teamviewer.enable = true;

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

  services.udev.extraRules = ''
# Teensy rules for the Ergodox EZ
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

# STM32 rules for the Moonlander and Planck EZ
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", \
    MODE:="0666", \
    SYMLINK+="stm32_dfu"
  '';
}
