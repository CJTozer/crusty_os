#!/usr/bin/env bash

. .os_test_vars

sd=$(dirname "$0")

function grab_file() {
    sudo cp $os_dir/$1 $sd/
    sudo chown $user:$user $1
}

grab_file update_files.sh
grab_file bochsrc
grab_file os-image