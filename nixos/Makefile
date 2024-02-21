create-classic:
	nix-build '<nixpkgs/nixos>' -A vm \
	-I nixpkgs=channel:nixos-23.11 \
	-I nixos-config=./flake.nix

create-flake:
	nix build .#nixosConfigurations.nixvm.config.system.build.vm

create-flake-native:
	nixos-rebuild build-vm --flake .#nixvm

run:
	QEMU_KERNEL_PARAMS=console=ttyS0 ./result/bin/run-nixos-vm -nographic
