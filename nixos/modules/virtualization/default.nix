{ config, pkgs, user, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    libvirtd.enable = true;
    virtualbox.host.enable = true;
  };
  boot.kernel.sysctl = { "net.ipv4.ip_forward" = 1; };
  environment.systemPackages = with pkgs; [
    docker-compose
    virtmanager
  ];
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  users.users.${user}.extraGroups = [ "libvirtd" "docker" ];
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
}
