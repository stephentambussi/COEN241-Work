#!/bin/bash

#This is to run the docker container for the file I/O tests
#Arg = 0 - low-end config
#Arg = 1 - middle-end config
#Arg = 2 - high-end config

contain_config=$1

if [ $contain_config -eq 0 ];
then
    sudo docker run --rm -it --cpuset-cpus="0-1" -m 2G --entrypoint /bin/sh zyclonite/sysbench

elif [ $contain_config -eq 1 ];
then
    sudo docker run --rm -it --cpuset-cpus="0-3" -m 4G --entrypoint /bin/sh zyclonite/sysbench

elif [ $contain_config -eq 2 ];
then
    sudo docker run --rm -it --cpuset-cpus="0-7" -m 8G --entrypoint /bin/sh zyclonite/sysbench

else
    echo "Incorrect Container Configuration selected."
    exit 1
fi