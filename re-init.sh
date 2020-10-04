cd ~/.nixconfig
git pull

sudo cp -rf ~/.nixconfig/nixos/* /etc/nixos/
mkdir -p /home/faebl/.config/nixpkgs
sudo cp -rf ~/.nixconfig/nixpkgs/* /home/faebl/.config/nixpkgs
sudo chmod -R ugo+rw /home/faebl/.config/nixpkgs

sudo nixos-rebuild switch --upgrade
