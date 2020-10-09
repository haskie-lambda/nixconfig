cd ~/.nixconfig
git pull

sudo cp -rf ~/.nixconfig/nixos/* /etc/nixos/
"include /etc/nixos/v2/theme.conf" >> /mnt/home/faebl/.config/kitty/kitty.conf
sudo chmod -R ugo+rw /mnt/home/faebl/.config

if [[ "$1" != "--home" ]]; then
  sudo nixos-rebuild switch --upgrade
fi
cd ~

if [[ "$1" != "--os" ]]; then
  home-manager build
fi
