{ config, lib, inputs, pkgs, ... }:
let
  DRIVE = "/dev/disk/by-id/wwn-0x5000c5009e0984c7";

  partitionsCreateScript = ''
    parted -s "${DRIVE}" -- mklabel gpt

    parted -s "${DRIVE}" -- mkpart ESP fat32 1MiB 513MiB
    parted -s "${DRIVE}" -- set 1 esp on
    mkfs.vfat "${DRIVE}"-part1

    parted -s "${DRIVE}" -- mkpart primary ext4 513MiB -25GiB
    mkfs.ext4 -F -L / "${DRIVE}"-part2

    parted -s "${DRIVE}" -- mkpart primary linux-swap -25GiB -8GiB
    mkswap -L swap "${DRIVE}"-part3
    parted -s "${DRIVE}" -- mkpart primary linux-swap -8GiB 100%
    mkswap -L swap "${DRIVE}"-part4

    mount "${DRIVE}"-part1 /mnt
    mkdir -p /mnt/boot
    mount "${DRIVE}" /mnt/boot
  '';
in
{
  config = {
    fileSystems."/boot" = {
      device = "${DRIVE}-part1";
      fsType = "vfat";
    };

    fileSystems."/" = {
      device = "${DRIVE}-part1";
      fsType = "ext4";
    };
    swapDevices = [
      { device = "${DRIVE}-part4"; }
    ];
    boot.resumeDevice = "${DRIVE}-part3";
    boot.kernelParams = [ "mem_sleep_default=deep" ];
  };
}
