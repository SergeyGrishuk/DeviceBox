#!/usr/bin/env bash


set -e


# This script complies and applies the SELinux policy. See the Wiki for more details.

if [[ -z "$(which checkmodule)" ]]
then
    echo -e '[-] Please install the `checkpolicy` and `policycoreutils-python-utils` packages.\nRun the following command and then rerun the script:\ndnf install -y checkpolicy policycoreutils-python-utils'

    exit
fi

checkmodule -M -m -o devicebox_heap.mod devicebox_heap.te
semodule_package -o devicebox_heap.pp -m devicebox_heap.mod
sudo semodule -i devicebox_heap.pp
