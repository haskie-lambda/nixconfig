cd ~/.nixconfig
git pull

sudo cp -rf ~/.nixconfig/nixos/* /etc/nixos/
#mkdir -p /home/faebl/.config/nixpkgs
#sudo cp -rf ~/.nixconfig/nixpkgs/* /home/faebl/.config/nixpkgs
#sudo chmod -R ugo+rw /home/faebl/.config/nixpkgs

#if [[ "$1" != "--home" ]]; then
  sudo nixos-rebuild switch --upgrade
#fi
#cd ~

#if [[ "$1" != "--os" ]]; then
#home-manager build
#fi
