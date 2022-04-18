#!/bin/bash

#Stephen Tambussi - COEN241 - HW1
#Script to run sysbench CPU tests

#Get current directory
dir=$(pwd)
#Check if file exists and create it if it does not
filename=$dir/sysbench_cpu_results.txt
if [ ! -f $filename ]
then
    touch $filename
    echo "QEMU VM Sysbench CPU Test Results" >> $filename
fi


#This gets the number of CPU cores allocated to the VM to detect current VM Config
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

#3 types of sysbench cpu tests with varying threads(2,4,8). Each of these tests are run 5 times on each VM config.
echo "CPU Test with 2 Threads" >> $filename
echo "-----------------------" >> $filename
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    sysbench --test=cpu --threads=2 --cpu-max-prime=10000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
done

echo "CPU Test with 4 Threads" >> $filename
echo "-----------------------" >> $filename
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    sysbench --test=cpu --threads=4 --cpu-max-prime=10000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
done

echo "CPU Test with 8 Threads" >> $filename
echo "-----------------------" >> $filename
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    sysbench --test=cpu --threads=8 --cpu-max-prime=10000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
done