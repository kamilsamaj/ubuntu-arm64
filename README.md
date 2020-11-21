# Ubuntu ARM64 (aarch64) QEMU VM

# Install prerequisites
```
sudo apt install -y qemu-system-arm qemu-efi-aarch64 qemu-utils cloud-image-utils
```

# Create UEFI volumes
```
dd if=/dev/zero of=flash0.img bs=1M count=64
dd if=/usr/share/qemu-efi/QEMU_EFI.fd of=flash0.img conv=notrunc
dd if=/dev/zero of=flash1.img bs=1M count=64
```

# Create CloudInit volume
```
cat > user-data <<EOF
#cloud-config
password: your_password
chpasswd: { expire: False }
ssh_pwauth: True
EOF

cloud-localds user-data.img user-data

# user-data.img MUST come after the rootfs.
qemu-system-x86_64 \
-drive file=ubuntu-18.04-server-cloudimg-amd64.img,format=qcow2 \
-drive file=user-data.img,format=raw \
-m 1G
...
```

# Download server image
http://cloud-images.ubuntu.com/focal/current/

# Start the instance
```
./start.sh
```

# Reset password after first login
```
passwd
```

# Reference
https://wiki.ubuntu.com/ARM64/QEMU
https://futurewei-cloud.github.io/ARM-Datacenter/qemu/how-to-launch-aarch64-vm/
https://stackoverflow.com/questions/29137679/login-credentials-of-ubuntu-cloud-server-image
