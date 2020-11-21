# Ubuntu ARM64 (aarch64) QEMU VM

# Install prerequisites
```

# Create UEFI volumes
```
dd if=/dev/zero of=flash0.img bs=1M count=64
dd if=/usr/share/qemu-efi/QEMU_EFI.fd of=flash0.img conv=notrunc
dd if=/dev/zero of=flash1.img bs=1M count=64
```

# Download server image
http://cloud-images.ubuntu.com/focal/current/

# Start the intance
```
./start.sh
```

# Reference
https://wiki.ubuntu.com/ARM64/QEMU
