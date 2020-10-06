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
    hostName = "faebl";
    useDHCP = false;
    interfaces.enc33.useDHCP = true;
    networkmanager.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "Europe/Vienna";

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraClientConf = "autospawn=yes\n";
  };

  powerManagement.resumeCommands = "
    echo 1 > '/sys/bus/pci/devices/0000:09:00.3/remove' \n
    echo 1 > '/sys/bus/pci/rescan'\n
    ";

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  users.users.faebl = {
    isNormalUser = true;
    home = "/home/faebl";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networking" ];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  system.stateVersion = "20.03";
}
