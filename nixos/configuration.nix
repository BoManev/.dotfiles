{ inputs, config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # boot.postBootCommands = ''
  #   cp ${./configuration.nix} /etc/nixos/configuration.nix
  #   cp ${./flake.nix} /etc/nixos/flake.nix
  # '';
  services.qemuGuest.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    inputs.helix.packages."${pkgs.system}".helix
  ];
  environment.variables.EDITOR = "vim";

  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      cowsay
      lolcat
    ];
    initialPassword = "test";
  };

  system.stateVersion = "23.11";
}
