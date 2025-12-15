#!/usr/bin/env bash


# This script complies and applies the SELinux policy. See the Wiki for more details.

checkmodule -M -m -o devicebox_heap.mod devicebox_heap.te
semodule_package -o devicebox_heap.pp -m devicebox_heap.mod
sudo semodule -i devicebox_heap.pp
