{ config, pkgs, ... }:

{

  imports = [
    ./basics.nix    
    # ./pkgConfigs.nix # (only in home-manager)    
    ./display.nix
  ];
  
  environment.systemPackages = ./packages.nix;
  nixpkgs.config.allowUnfree = true;  
}
     
