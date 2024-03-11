{ pkgs, ... }:
{
  users.users.bo = {
    isNormalUser = true;
    description = "Bo Manev";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
}

