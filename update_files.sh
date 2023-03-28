#!/usr/bin/env bash

. .os_test_vars

sd=$(dirname "$0")

function grab_file() {
    target=$(basename $1)
    sudo cp $os_dir/$1 $sd/$target
    sudo chown $user:$user $target
}

grab_file update_files.sh
grab_file bochsrc
grab_file output/os-image