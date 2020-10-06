{ config, pkgs, ... }:

{

  imports = [
    ./basics.nix    
    # ./pkgConfigs.nix # (only in home-manager)    
    ./display.nix
  ];
  
  environment.systemPackages = import ./packages.nix pkgs;
  nixpkgs.config.allowUnfree = true;  
}
     
