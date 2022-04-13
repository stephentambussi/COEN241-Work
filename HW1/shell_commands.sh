#QEMU VM commands
#Note: needs to be run in /Documents directory
#For install 
sudo qemu-system-x86_64 -m 4096 -boot d -accel kvm -cpu EPYC -smp cores=3 -boot strict=on -hda ubuntu.img -cdrom ubuntu-20.04.4-live-server-amd64.iso 

#To run after install
sudo qemu-system-x86_64 -m 4096 -boot d -accel kvm -cpu EPYC -smp cores=3,threads=2 -boot strict=on -hda ubuntu.img

#Run sysbench CPU on VM
sysbench --test=cpu --cpu-max-prime=5000 --time=30 run

#Run sysbench file IO on VM -- Note: --file-total-size=XXG change the test file size for file IO test
sysbench --test=fileio --file-test-mode=seqwr run
#Delete test file on VM
sysbench --test=fileio cleanup
#Drop the cache on VM
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

#Docker commands
#Run sysbench CPU in container
sudo docker run --rm --cpus=3 -m 4G zyclonite/sysbench --test=cpu --cpu-max-prime=5000 --time=30 run
#Run sysbench file IO in container
sudo docker run --rm --cpus=3 -m 4G zyclonite/sysbench --test=fileio --file-test-mode=seqwr run
#Delete test file in container
sudo docker run --rm --cpus=3 -m 4G zyclonite/sysbench --test=fileio cleanup
#Drop the cache on system
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'