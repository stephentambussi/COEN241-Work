#Note: needs to be run in /Documents directory
#For install
sudo qemu-system-x86_64 -m 4096 -boot d -accel kvm -cpu EPYC -smp cores=3 -boot strict=on -hda ubuntu.img -cdrom ubuntu-20.04.4-live-server-amd64.iso 

#After install
sudo qemu-system-x86_64 -m 4096 -boot d -accel kvm -cpu EPYC -smp cores=3,threads=2 -boot strict=on -hda ubuntu.img