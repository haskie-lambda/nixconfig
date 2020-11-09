$username="faebl"
cd ~/.nixconfig
git pull

sudo cp -rf ~/.nixconfig/nixos/* /etc/nixos/
sudo sed -i -e 's/USERNAME/$username/g' /etc/nixos/v2/basics.nix
"include /etc/nixos/v2/theme.conf" >> /home/$username/.config/kitty/kitty.conf
mkdir -p /home/$username/.config/i3status
cp -rf ./nixos/v2/i3status.config/* /home/$username/.config/i3status/config
mkdir -p /home/$username/.config/nixpkgs

cp home.nix /home/$username/.config/nixpkgs
sudo chmod -R ugo+rw /home/$username/.config

if [[ "$1" != "--home" ]]; then
  sudo nixos-rebuild switch --upgrade
fi
cd ~

if [[ "$1" != "--os" ]]; then
  home-manager build
fi
