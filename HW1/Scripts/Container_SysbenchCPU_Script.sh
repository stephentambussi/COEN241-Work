#!/bin/bash

#Stephen Tambussi - COEN241 - HW1
#Script to run sysbench CPU tests

#Get current directory
dir=$(pwd)
#Check if file exists and create it if it does not
filename=$dir/container_sysbench_cpu_results.txt
if [ ! -f $filename ]
then
    touch $filename
    echo "Docker Container Sysbench CPU Test Results" >> $filename
fi

echo "Low-end Container Configuration Tests: 1 core, 2 threads, 2 GB Mem" >> $filename
echo "===========================================================" >> $filename
echo "Low-end tests"
echo "CPU Test with 2 Threads" >> $filename
echo "-----------------------" >> $filename
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    sudo docker run --rm --cpuset-cpus="0-1" -m 2G zyclonite/sysbench --test=cpu --threads=2 --cpu-max-prime=10000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
done

echo "CPU Test with 4 Threads" >> $filename
echo "-----------------------" >> $filename
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    sudo docker run --rm --cpuset-cpus="0-1" -m 2G zyclonite/sysbench --test=cpu --threads=4 --cpu-max-prime=10000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
done

echo "CPU Test with 8 Threads" >> $filename
echo "-----------------------" >> $filename
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    sudo docker run --rm --cpuset-cpus="0-1" -m 2G zyclonite/sysbench --test=cpu --threads=8 --cpu-max-prime=10000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
done

echo "Middle-end Container Configuration Tests: 2 cores, 4 threads, 4 GB Mem" >> $filename
echo "===========================================================" >> $filename
echo "Middle-end tests"
echo "CPU Test with 2 Threads" >> $filename
echo "-----------------------" >> $filename
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    sudo docker run --rm --cpuset-cpus="0-3" -m 4G zyclonite/sysbench --test=cpu --threads=2 --cpu-max-prime=10000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
done

echo "CPU Test with 4 Threads" >> $filename
echo "-----------------------" >> $filename
echo "CPU Test with 4 Threads -- CPU utilization should become higher"
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    sudo docker run --rm --cpuset-cpus="0-3" -m 4G zyclonite/sysbench --test=cpu --threads=4 --cpu-max-prime=10000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
done

echo "CPU Test with 8 Threads" >> $filename
echo "-----------------------" >> $filename
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    sudo docker run --rm --cpuset-cpus="0-3" -m 4G zyclonite/sysbench --test=cpu --threads=8 --cpu-max-prime=10000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
done

echo "High-end Container Configuration Tests: 4 cores, 8 threads, 8 GB Mem" >> $filename
echo "===========================================================" >> $filename
echo "High-end tests"
echo "CPU Test with 2 Threads" >> $filename
echo "-----------------------" >> $filename
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    sudo docker run --rm --cpuset-cpus="0-7" -m 8G zyclonite/sysbench --test=cpu --threads=2 --cpu-max-prime=10000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
done

echo "CPU Test with 4 Threads" >> $filename
echo "-----------------------" >> $filename
echo "CPU Test with 4 Threads -- CPU utilization should become higher"
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    sudo docker run --rm --cpuset-cpus="0-7" -m 8G zyclonite/sysbench --test=cpu --threads=4 --cpu-max-prime=10000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
done

echo "CPU Test with 8 Threads" >> $filename
echo "-----------------------" >> $filename
echo "CPU Test with 8 Threads -- CPU utilization should become higher"
for ((counter=1; counter<6; counter++))
do
    echo "TEST $counter" >> $filename
    sudo docker run --rm --cpuset-cpus="0-7" -m 8G zyclonite/sysbench --test=cpu --threads=8 --cpu-max-prime=10000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
done