#!/bin/bash

# Created by: Tyler Petty
# Date: 2/1/22
# Version: 2

# Change log: 
#   Added script parameters when executing

# To do: 
#   Error handling of parameter

# Summary: 
#   The -A option for nmap "Enable OS detection, version detection, script scanning, and traceroute"
#   When performing a nmap scan of a target using the -A option, it can be time-consuming because nmap will attempt this enumeration on each port scanned
#   To speed up the scan, only perform a -A scan on open ports
#   This script first identifies open ports then passes those open ports to another nmap scan with the -A option, thus speeding up the enumeration (depending on some factors)

# Variables
dt=$(date +%F_%T) # Get current date/time
file_to_save=nmapOutput-${dt} # file name w/ date/time appended

if [ "$1" == "" ] # check if script was run with parameter
then # if no parameter specified then run below
echo "You forgot to specify the IP address!"
echo "Syntax: ./automated_nmap.sh 192.168.1.1"
else # if parameter specified then continue with below

output=$(nmap -T4 $1 -p- | grep open | cut -d "/" -f 1) # scan the IP provided as a script parameter for any open ports. Grep & cut ensure only Open port numbers are returned

for port in $output; do # for each port number returned by $output, do...

nmap $1 -A -p $port >> $file_to_save # an nmap scan with -A on each port number provided

done # end of for loop

fi # end of if statement

exit 0 # end of script