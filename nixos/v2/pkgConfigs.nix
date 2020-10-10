{ lib,  ... }:


#        let
#          generatedOverrides = haskellPackagesNew: haskellPackagesOld:
#            let
#              toPackage = file: _: {
#                name  = builtins.replaceStrings [ ".nix" ] [ "" ] file;
#
#                value = haskellPackagesNew.callPackage (./. + "/nix/${file}") { };
#              };
#
#            in
#              pkgs.lib.mapAttrs' toPackage (builtins.readDir ./nix);
#
#          makeOverrides =
#            function: names: haskellPackagesNew: haskellPackagesOld:
#              let
#                toPackage = name: {
#                  inherit name;
#
#                  value = function haskellPackagesOld.${name};
#                };
#
#            in
#              builtins.listToAttrs (map toPackage names);
#
#          composeExtensionsList =
#            pkgs.lib.fold pkgs.lib.composeExtensions (_: _: {});
#
#          # More exotic overrides go here
#          manualOverrides = haskellPackagesNew: haskellPackagesOld: {
#          };

# let 
#   folder = ./. + "/pkgConfigs/";
# in 
# let
#   toPkg = file: (folder + "/${file}");
# in
# {
#     imports = (pkgs.lib.mapAttrs' toPkg (builtins.readDir folder));
# } 
#

with lib;
let
  # Recursively constructs an attrset of a given folder, recursing on directories, value of attrs is the filetype
  getDir = dir: mapAttrs
    (file: type:
      if type == "directory" then getDir "${dir}/${file}" else type
    )
    (builtins.readDir dir);

  # Collects all files of a directory as a list of strings of paths
  files = dir: collect isString (mapAttrsRecursive (path: type: concatStringsSep "/" path) (getDir dir));

  # Filters out directories that don't end with .nix or are this file, also makes the strings absolute
  validFiles = dir: map
    (file: ./. + "/pkgConfigs/${file}")
    (filter
      (file: hasSuffix ".nix" file && file != "default.nix")
      (files dir));

in
{

  imports = validFiles (./. + "/pkgConfigs");

}
