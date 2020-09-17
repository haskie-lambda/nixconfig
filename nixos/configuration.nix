{ config, pkgs, ... }:

{
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./devices/private_machine.nix
  ];

  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "man" ];
    theme = "agnoster";
  };
}
