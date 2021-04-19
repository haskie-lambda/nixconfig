{ config, pkgs, ... }:

{ 
  boot = {
    kernelModules = [ "snd-seq" "snd-rawmidi" ];
    kernel.sysctl = { "vm.swappiness" = 10; "fs.inotify.max_user_watches" = 524288; };
    kernelParams = [ "threadirq" ];
    #kernelPackages = let 
    #  rtKernel = pkgs.linuxPackagesFor (pkgs.linux.override {
    #    extraConfig = ''
    #      PREEMPT_RT_FULL? y
    #      PREEMPT y
    #      IOSCHED_DEADLINE y
    #      DEFAULT_DEADLINE y
    #      DEFAULT_IOSCHED "deadline"
    #      HPET_TIMER y
    #      CPU_FREQ n
    #      TREE_RCU_TRACE n
    #    '';
    #  }) pkgs.linuxPackages;
    #in rtKernel;

    postBootCommands = ''
      echo 2048 > /sys/class/rtc/rtc0/max_user_freq
      echo 2048 > /proc/sys/dev/hpet/max-user-freq
      setpci -v -d *:* latency_timer=b0
      setpci -v -s $00:1b.0 latency_timer=ff
    '';
    # The SOUND_CARD_PCI_ID can be obtained like so:
    # $lspci | grep -i audio
  };

  powerManagement.cpuFreqGovernor = "performance";

  fileSystems."/" = { options = [ "noatime errors=remount-ro" ]; };

  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
    { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];

  services = {
    udev = {
      extraRules = ''
        KERNEL=="rtc0", GROUP="audio"
        KERNEL=="hpet", GROUP="audio"
      '';
    };
  };

 
  environment.shellInit = ''
    export VST_PATH=/nix/var/nix/profiles/default/lib/vst:/var/run/current-system/sw/lib/vst:~/.vst
    export LXVST_PATH=/nix/var/nix/profiles/default/lib/lxvst:/var/run/current-system/sw/lib/lxvst:~/.lxvst
    export LADSPA_PATH=/nix/var/nix/profiles/default/lib/ladspa:/var/run/current-system/sw/lib/ladspa:~/.ladspa
    export LV2_PATH=/nix/var/nix/profiles/default/lib/lv2:/var/run/current-system/sw/lib/lv2:~/.lv2
    export DSSI_PATH=/nix/var/nix/profiles/default/lib/dssi:/var/run/current-system/sw/lib/dssi:~/.dssi
  '';

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraClientConf = "autospawn=yes\n";
    package = pkgs.pulseaudioFull.override { jackaudioSupport = true; };
    #extraConfig = ''
    #    load-sample-lazy x11-bell /usr/share/sounds/freedesktop/stereo/bell.oga
    #    load-module module-x11-bell sample=x11-bell
    #    '';

  };

  services.jack = {
    jackd.enable = true;
    alsa.enable = false;
    loopback = {
      enable = true;
    };
  };

  systemd.user.services.pulseaudio.environment = {
    JACK_PROMISCUOUS_SERVER = "jackaudio";
  };
}
