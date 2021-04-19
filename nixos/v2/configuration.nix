{ options, config, pkgs, ... }:
{
  nix.nixPath =
    options.nix.nixPath.default ++ 
    [ "nixpkgs-overlays=/etc/nixos/v2/overlays/" ]
  ;

  nixpkgs.overlays = [
    (
        final: prev:
        {
          virtualbox = prev.virtualbox.overrideAttrs (old: {
              patches = (old.patches or []) ++ 
                [ /etc/nixos/v2/pkgConfigs/vBoxLinux5-11.patch ];
          });
        }
    )
  ];

  imports = [
    ./basics.nix    
    # ./pkgConfigs.nix # (only in home-manager)    
    ./display.nix
    ./nixpkgsSettings.nix
  ];
    

  environment.systemPackages = import ./packages.nix pkgs;

  nixpkgs.config.allowUnfree = true;  
}
     
