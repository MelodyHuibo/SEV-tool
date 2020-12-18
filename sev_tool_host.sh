#!/bin/bash

cpuid > cpuidtest.txt

cpuid |grep vendor_id | sort -u 
#cpuid |grep -m1 vendor_id 
#cpuid |grep family | sort -u
cpuid |grep -m1 family

echo "$1 related information"
dmesg | grep -i $1

echo "Has $2 module: true if 1"
cat /sys/module/kvm_amd/parameters/$2


