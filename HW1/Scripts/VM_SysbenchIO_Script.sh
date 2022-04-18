#!/bin/bash

#Stephen Tambussi - COEN241 - HW1
#Script to run sysbench file io tests

#Get current directory
dir=$(pwd)
#Check if file exists and create it if it does not
filename=$dir/vm_sysbench_io_results.txt
if [ ! -f $filename ]
then
    touch $filename
    echo "QEMU VM Sysbench File IO Test Results" >> $filename
fi

#This gets the number of CPU cores allocated to the VM to detect current VM config
cpus=$(lscpu | grep "Core(s) per socket:" | grep -Eo '[0-9]')

if [ $cpus -eq 1 ]; #Low-end config - 1 core, 2 threads
then
    echo "Low-end VM Configuration Tests: 1 core, 2 threads, 2 GB Mem" >> $filename
    echo "===========================================================" >> $filename

elif [ $cpus -eq 2 ]; #Middle-end config - 2 cores, 4 threads
then
    echo "Middle-end VM Configuration Tests: 2 cores, 4 threads, 4 GB Mem" >> $filename
    echo "===========================================================" >> $filename

elif [ $cpus -eq 4 ]; #High-end config - 4 cores, 8 threads
then
    echo "High-end VM Configuration Tests: 4 cores, 8 threads, 8 GB Mem" >> $filename
    echo "===========================================================" >> $filename

else
    echo "Incorrect number of cores to run sysbench, needs to match preset configs"
    exit 1
fi

echo "File IO Test in Sequential Write Mode" >> $filename
echo "-------------------------------------" >> $filename
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    #Create the files to test
    sysbench --test=fileio --file-num=128 --file-total-size=10G prepare
    #Run the actual test
    sysbench --test=fileio --file-num=128 --file-total-size=10G --file-test-mode=seqwr run \
    | grep "Throughput:\|read, MiB/s:\|written, MiB/s:\|Latency (ms):\|min:\|avg:\|max:\|95th percentile:\|sum:" >> $filename
    #Cleanup the test files
    sysbench --test=fileio cleanup
    #Drop the cache
    sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
done

echo "File IO Test in Sequential Read Mode" >> $filename
echo "-------------------------------------" >> $filename
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    #Create the files to test
    sysbench --test=fileio --file-num=128 --file-total-size=10G prepare
    #Run the actual test
    sysbench --test=fileio --file-num=128 --file-total-size=10G --file-test-mode=seqrd run \
    | grep "Throughput:\|read, MiB/s:\|written, MiB/s:\|Latency (ms):\|min:\|avg:\|max:\|95th percentile:\|sum:" >> $filename
    #Cleanup the test files
    sysbench --test=fileio cleanup
    #Drop the cache
    sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
done