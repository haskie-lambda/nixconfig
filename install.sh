set -e
username="faebl"
if [[ "$1" != "--rebuild" ]] && [[ "$1" != "--reinstall" ]] ; then 

  # PARTITIONING
  # EDIT THIS
  dev=/dev/nvme0n1
  parted $dev -- mklabel gpt
  parted $dev -- mkpart primary 512MiB 230GiB
  parted $dev -- mkpart primary linux-swap 230GiB 100%
  parted $dev -- mkpart ESP fat32 1MiB 512MiB
  parted $dev -- set 3 boot on

  mkfs.ext4 -L crypted "${dev}p1"
  mkswap -L swap "${dev}p2"
  swapon "${dev}p2"
  mkfs.fat -F 32 -n boot "${dev}p3"        # (for UEFI systems only)

  # CREATION OF ENCRYPTED HOME
  cryptsetup luksFormat "${dev}p1"


  cryptsetup luksOpen "${dev}p1" crypted
  mkfs.ext4 /dev/mapper/crypted
  mount /dev/mapper/crypted /mnt
  mkdir -p /mnt/boot                      # (for UEFI systems only)
  mount /dev/disk/by-label/boot /mnt/boot # (for UEFI systems only)

  nixos-generate-config --root /mnt

else

  cd nixconfig
  git pull

fi

# user space stuff like home manager, kitty, i3status configurations
rm /mnt/etc/nixos/configuration.nix
yes | cp -rf ./nixos/* /mnt/etc/nixos/

mkdir -p /mnt/home/$username/.config/kitty
echo "include /etc/nixos/v2/theme.conf" >> /mnt/home/$username/.config/kitty/kitty.conf

mkdir -p /mnt/home/$username/.config/i3status
cp -rf ./nixos/v2/i3status.config /mnt/home/$username/.config/i3status/config

mkdir -p /mnt/home/$username/.config/nixpkgs
cp home.nix /mnt/home/$username/.config/nixpkgs


sudo chmod -R ugo+rw /mnt/home/$username/.config

sudo sed -i -e "s/USERNAME/$username/g" /mnt/etc/nixos/v2/basics.nix

nixos-install
#reboot
