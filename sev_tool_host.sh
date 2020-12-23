#!/bin/bash

cpuid > cpuidtest.txt

echo "Vendor information:"
cpuid |grep vendor_id | sort -u 
#grep -n -m1 "vendor_id" cpuidtest.txt 
#cpuid |grep -m1 vendor_id 
#cpuid |grep family | sort -u
echo "CPU family information:"
cpuid |grep -m1 family

echo "CPUIDFn8000_001F information: 0x8000001f[eax], 0x8000001f[ebx], 0x8000001f[ecx], 0x8000001f[edx]:"
grep -n -m1 "0x8000001f" cpuidtest.txt |cut -f3- -d:

((B=$(grep -n -m1 "0x8000001f" cpuidtest.txt | cut -f5- -d=) - 1))
echo "ASID range for SEV-ES and SEV-SNP range is 1 to $B"

echo "$1 related information :"
dmesg | grep -i $1 > dmesg_$1.txt
echo "Grub configuration including snp flag, and VM memory total memory size:"
grep -n -m1 "Command line" dmesg_$1.txt |cut -f2- -d] 
grep -n -m1 "usb" dmesg_$1.txt |cut -f2- -d] a
echo "Kernel version:"
grep -n -m1 "Linux version" dmesg_$1.txt |cut -f2- -d] 
echo "$1 enable information and build version:"
grep -n -m1 "ccp" dmesg_$1.txt |cut -f2- -d] 
grep -n -m1 "SEV-SNP" dmesg_$1.txt |cut -f2- -d] 
grep -n -m1 "SEV" dmesg_$1.txt |cut -f2- -d] 
grep -n -m1 "SEV-ES" dmesg_$1.txt |cut -f2- -d] 

if [[ $(cat /sys/module/kvm_amd/parameters/$2) -eq 1 ]]
then
  echo "$2 module exists"
else
  echo "$2 module does not exist"
fi
#echo "Has $2 module: true if 1"
#echo "value is $(cat /sys/module/kvm_amd/parameters/$2)"

echo "Read RMP table address space:"
sudo modprobe msr

echo "RMP table base address"
sudo rdmsr -x 0xc0010132

echo "RMP table end address"
sudo rdmsr -x 0xc0010133

