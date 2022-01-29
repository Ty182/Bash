#!/bin/bash

# Source: TheCyberMentor - Practical Ethical Hacking course
# Modified by: Tyler Petty
# Date: 1/27/22
# Change log: addded comments

# $1 is a parameter when running the script. If no parameter specified, then echo out the error i.e. "You forgot.."

if [ "$1" == "" ]
then
echo "You forgot an IP address!"
echo "Syntax: ./ipsweep.sh 192.168.1"

# If a parameter was specified then continue with script
else

# 'ip' becomes the variable for each number generated, in this case 1 - 254. FYI - these are backtics (from the tilda key)
for ip in `seq 1 254`; do

# ping the IP address (supplied as the script parameter) and fill in the 4th octet with whatever numnber is held in the $ip variable. If an IP is found to be valid, the info returned will be "64 bytes" so we grep on this i.e., only grab valid IP's. Then we cut all the other info returned except for the IP. Use tr to remove the : at the end of the IP. The & is to allow for threading i.e., ping more than one IP at a time
ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
done
fi
