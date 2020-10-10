# Installation

Installation of the config is automated. Simply boot the system into a nixos live environment, connect it to the internet ([good instructions here](https://www.linuxbabe.com/command-line/ubuntu-server-16-04-wifi-wpa-supplicant)) and type the following command:

```
$ curl digital-independence.xyz/nix-install.sh > install.sh && sudo sh install.sh
```

this will download an installation script and open it in VIM for editing.

Type `i` to go to insert mode and then change your username in the 
variable on the first line. By default this username will also become the machines hostname.
Next customize your partitioning scheme in the partiton table part of the script.
Finally, if you want to make any changes to the nix config before installing it, comment out the `nixos-install` line at the bottom of the script.
Type `[ESC]:wq` to apply your changes and exit the script.

The script will prompt you to enter the password for the enrcypted home partiton. Enter it twice.
If you haven't commented out the `nixos-install` line, the installation of the config will now begin. This will take some time.
After successful installation, you will be prompted to enter a root password. Enter it twice.
After this the script is finished.
If you have entered the root password incorrectly or you want to set the user password, use

```
nixos-enter `/mnt`
```

and then `passwd` to change the root password or `passwd [username]` to set the user password.

then type 

```
sudo reboot now
```

and see your new system starting.

# Post installation stuff
`home-manager` sets up part of the system and will need to be run post installation.
for that login to your system, open a terminal (using `[ALT]+[ENTER]`, ignore any messages that might pop up and then type

```
home-manager switch
```
this will install the rest of your configuration, including a more or less secure firefox that is rebuilt from scratch, so this will take some time again.

afterwards the system installation is complete and you can enjoy your new OS(config).

for features browse the configuration.

# Working with the configuration afterwards
my way of using it is like this:
i cloned this repository to `~/.nixconfig`.
Now every time I want to make a change to the config as a whole, i make the change in this directory and use the `re-init.sh` script to apply my changes (along with either one of the `--os` (deploy everything but only activate the nix-config changes) `--home` (deploy everything but only activate the home-manager changes)).
then i also sync that change back to my repository for keeping it up to date.

This way, whenever I want a new development environment on a different machine or in a vm, my config there is always synched up with my main configuration. (To use it that way, fork the project, deploy your own public reachable `nix-install.sh` script that downloads your custom repo and you have the exact same setup that I use for daily work ;)


# Todo
- add post-installation `home-manager switch` to install script
- add git repo cloning to install script to give the user access to `re-init.sh` for resetting
- add more comments to nix-config for explaining features
