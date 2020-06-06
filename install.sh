if [ "$1" != "--rebuild" ]; then 

  # PARTITIONING
  parted /dev/sda -- mklabel gpt
  parted /dev/sda -- mkpart primary 512MiB 46GiB
  parted /dev/sda -- mkpart primary linux-swap 46GiB 100%
  parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
  parted /dev/sda -- set 3 boot on

  mkfs.ext4 -L crypted /dev/sda1
  mkswap -L swap /dev/sda2
  swapon /dev/sda2
  mkfs.fat -F 32 -n boot /dev/sda3        # (for UEFI systems only)

  # CREATION OF ENCRYPTED HOME
  until (cryptsetup luksFormat /dev/sda1)
  do
    echo "Try again"
  done


  cryptsetup luksOpen /dev/sda1 crypted
  mkfs.ext4 /dev/mapper/crypted
  mount /dev/mapper/crypted /mnt
  mkdir -p /mnt/boot                      # (for UEFI systems only)
  mount /dev/disk/by-label/boot /mnt/boot # (for UEFI systems only)

  nixos-generate-config --root /mnt

else
  git pull
  cd ..
fi


rm /mnt/etc/nixos/configuration.nix
yes | cp -rf ./nixos/* /mnt/etc/nixos/
mkdir -p /mnt/home/faebl/.config/nixpkgs
yes | cp -rf ./nixpkgs/* /mnt/home/faebl/.config/nixpkgs

nixos-install
#reboot
