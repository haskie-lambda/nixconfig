{ config, pkgs, ... }:

{
    # Binary Cache for Haskell.nix
    nix.binaryCachePublicKeys = [
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    ];
    nix.binaryCaches = [
        "https://hydra.iohk.io"
        "https://cache.nixos.org"
        "https://nixcache.reflex-frp.org"
    ];    
}
