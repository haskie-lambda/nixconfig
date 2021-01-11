{ pkgs, .. }:

pkgs.overlays = [(self: super: 
      { discord = super.discord.overrideAttrs (_: 
          { src = builtins.fetchTarball https://dl.discordapp.net/apps/linux/0.0.13/discord-0.0.13.tar.gz;
        }
        )
      }
    ];
