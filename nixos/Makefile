ISO_FILE := result/iso/nixos-*.iso
TEST_ISO_MNT_DIR := mnt

# VM
create-vm:
	nix build .#nixosConfigurations.nixvm.config.system.build.vm

run-vm: create-vm
	QEMU_KERNEL_PARAMS=console=ttyS0 ./result/bin/run-nixos-vm -nographic

clean-vm:
	rm -f nixos.qcow2

run-vm-clean: clean-vm run-vm

# ISO
create-iso:
	nix build .#nixosConfigurations.nixiso.config.system.build.isoImage

mount-test-iso: create-iso
	mkdir -p $(TEST_ISO_MNT_DIR)
	sudo mount -o loop $(ISO_FILE) $(TEST_ISO_MNT_DIR)

boot-test-iso: mount-test-iso
	nix-shell -p qemu --run "qemu-system-x86_64 -enable-kvm -m 256 -cdrom $(ISO_FILE)"
	$(MAKE) umount-test-iso

umount-test-iso:
	if mountpoint -q $(TEST_ISO_MNT_DIR); then \
		sudo umount -f $(TEST_ISO_MNT_DIR); \
	fi
	rm -rf $(TEST_ISO_MNT_DIR)

# ADMIN
rebuild:
	nixos-rebuild build-vm --flake .#nixvm

clean: umount-test-iso clean-vm
	rm result
	@echo "Cleaning up..."

.PHONY: mount-test-iso \
	umount-test-iso \
	boot-test-iso \
	clean \
	run-vm \
	create-iso \
	rebuild \
	create-vm
