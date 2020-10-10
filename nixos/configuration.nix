{ config, pkgs, ... }:

{
  imports = [ 
     ./hardware-configuration.nix
     ./v2/configuration.nix 
  ];

}
