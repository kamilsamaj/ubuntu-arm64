#!/bin/bash
# create a tap nic
if ! ip a show tap0 &>/dev/null; then
    sudo ip tuntap add dev tap0 mode tap
    sudo ip link set tap0 up promisc on
    sudo ip link set dev virbr0 up
    sudo ip link set dev tap0 master virbr0
fi

    #-netdev type=tap,id=net0 \
#sudo qemu-system-aarch64 \
#    -M virt \
#    -cpu cortex-a57 \
#    -m 2048 \
#    -pflash flash0.img \
#    -pflash flash1.img \
#    -drive if=none,file=focal-server-cloudimg-arm64.img,id=hd0 \
#    -device virtio-blk-device,drive=hd0 \
#    -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
#    -device vmxnet3,netdev=net0,id=net0,mac=01:02:03:04:05:05 \
#    -nographic

qemu-system-aarch64 \
    -nographic \
    -machine virt,gic-version=max \
    -m 2048M \
    -cpu max \
    -smp 4 \
    -netdev user,id=vnet,hostfwd=:127.0.0.1:5022-:22 \
    -device virtio-net-pci,netdev=vnet \
    -drive file=focal-server-cloudimg-arm64.img,if=none,id=drive0,cache=writeback \
    -drive file=user-data.img,format=raw \
    -device virtio-blk,drive=drive0,bootindex=0 \
    -drive file=flash0.img,format=raw,if=pflash \
    -drive file=flash1.img,format=raw,if=pflash
