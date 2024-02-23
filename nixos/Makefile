SHELL := /bin/bash
ISO_FILE := $(shell find result/iso -name 'nixos-*.iso' -type f -print -quit)
TEST_ISO_MNT_DIR := mnt
TEST_KVM_IMG := ./virt/nixos.img

# VM
create-vm:
	nix build .#nixosConfigurations.nixvm.config.system.build.vm

emulate-vm: create-vm
	QEMU_KERNEL_PARAMS=console=ttyS0 ./result/bin/run-nixos-vm -nographic

clean-vm:
	rm -f nixos.qcow2

emulate-vm-clean: clean-vm run-vm

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

init-iso: create-iso
	@echo $(ISO_FILE)
	sudo virt-install \
		--name=nixos-vm \
		--vcpu=2 \
		--ram=2048 \
		--disk path=$(TEST_KVM_IMG),size=15 \
		--graphics spice \
		--cdrom=$(ISO_FILE) \
		--network bridge:virbr0

# Official ISO [ORIGIN]
# ====================
ORIGIN_ISO := latest-nixos-minimal-x86_64-linux.iso
download-origin-iso:
	@echo "[download-origin-iso] checking if $(ORIGIN_ISO) exists"
	@if [ ! -f ./virt/latest-nixos-minimal-x86_64-linux.iso ]; then \
		echo -e "\t$(ORIGIN_ISO) downloading..."; \
		wget -P ./virt https://channels.nixos.org/nixos-23.11/latest-nixos-minimal-x86_64-linux.iso; \
	else \
		echo -e "\tiso already exists"; \
	fi;

ORIGIN_NET_IFACE := virbr0
pre-create-origin-vm:
	@echo "[setup-origin-vm] checking if $(ORIGIN_NET_IFACE) exists"
	if [[ ! -e /sys/class/net/virbr0 ]]; then \
		echo -e "\t$(ORIGIN_NET_IFACE) creating..."; \
		sudo virsh net-start default; \
	else \
		echo -e "\t$(ORIGIN_NET_IFACE) already exists"; \
	fi;

ORIGIN_VM_NAME := origin-vm
ORIGIN_VM_DISK := ./virt/origin.qcow2
run-origin-vm: download-origin-iso pre-create-origin-vm
	@echo "[create-origin-vm] checking if $(ORIGIN_VM_NAME) exists"
	@if ! virsh dominfo $(ORIGIN_VM_NAME) > /dev/null 2>&1; then \
        echo -e "\tvm not founds, creating..."; \
        sudo virt-install \
			--name=$(ORIGIN_VM_NAME) \
			--vcpu=2 \
			--ram=2048 \
			--disk $(ORIGIN_VM_DISK),device=disk,bus=virtio,size=15 \
			--nographics \
			--cdrom=./virt/$(ORIGIN_ISO) \
			--console pty,target_type=virtio \
			--network network=default; \
	else \
		if [ "$$(virsh domstate $(ORIGIN_VM_NAME))" = "running" ]; then \
			echo -e "\tvm exists and running, rebooting..."; \
			sudo virsh reboot $(ORIGIN_VM_NAME); \
		else \
			echo -e "\tvm exists and stopped, starting..."; \
			sudo virsh start $(ORIGIN_VM_NAME); \
		fi; \
		virt-viewer $(ORIGIN_VM_NAME); \
	fi;

clean-origin-vm:
	@echo "[clean-origin-vm] cleaning $(ORIGIN_VM_NAME)..."
	@if virsh dominfo $(ORIGIN_VM_NAME) > /dev/null 2>&1; then \
		sudo virsh destroy $(ORIGIN_VM_NAME); \
		sudo virsh undefine $(ORIGIN_VM_NAME) --nvram; \
	fi;
	@rm -f $(ORIGIN_VM_DISK)
	@if [[ -e /sys/class/net/$(ORIGIN_NET_IFACE) ]]; then \
		sudo virsh net-destroy default; \
	fi;


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
