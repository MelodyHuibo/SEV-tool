#!/bin/bash

cpuid > cpuidtest.txt

echo "Vendor information"
cpuid |grep vendor_id | sort -u 
#grep -n -m1 "vendor_id" cpuidtest.txt 
#cpuid |grep -m1 vendor_id 
#cpuid |grep family | sort -u
echo "CPU family information"
cpuid |grep -m1 family

echo "CPUIDFn8000_001F information: 0x8000001f[eax], 0x8000001f[ebx], 0x8000001f[ecx], 0x8000001f[edx]"
grep -n -m1 "0x8000001f" cpuidtest.txt

((B=$(grep -n -m1 "0x8000001f" cpuidtest.txt | cut -f5- -d=) - 1))
echo "ASID for ES and SNP range is 1 to $B"

echo "$1 related information"
dmesg | grep -i $1

echo "Has $2 module: true if 1"
echo "value is $(cat /sys/module/kvm_amd/parameters/$2)"

echo "Read RMP table address space:"
sudo modprobe msr

echo "RMP table base address"
sudo rdmsr -x 0xc0010132

echo "RMP table end address"
sudo rdmsr -x 0xc0010133

