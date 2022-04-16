#QEMU VM commands
#Note: needs to be run in /Documents directory
#For install -- to speed it up
sudo qemu-system-x86_64 -m 4096 -boot d -accel kvm -cpu EPYC -smp cores=4,threads=2 -boot strict=on -hda ubuntu.img -cdrom ubuntu-20.04.4-live-server-amd64.iso 

#To run after install
sudo qemu-system-x86_64 -m 4096 -boot d -accel kvm -cpu EPYC -smp cores=2,threads=2 -nic user,hostfwd=tcp::2222-:22 -boot strict=on -hda ubuntu.img

#To ssh from host to VM
ssh stambussi@127.0.0.1 -p 2222

#To transfer file from host to VM using scp
sudo scp -P 2222 <source-file> stambussi@127.0.0.1:<destination-path>

#Run sysbench CPU on VM
sysbench --test=cpu --cpu-max-prime=5000 --time=30 run

#Prepare sysbench file IO test
sysbench --test=fileio --file-num=128 --file-total-size=10G prepare
#Run sysbench file IO on VM -- Note: --file-total-size=XXG change the test file size for file IO test
sysbench --test=fileio --file-num=128 --file-total-size=10G --file-test-mode=seqrewr run
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