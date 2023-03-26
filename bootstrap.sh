#!/usr/bin/env bash
# Bootstrap script for the testing VM (folder mounted in, everything has wrong permissions!)

# Get the script dir and working dir
wd=$(pwd)
sd=$(dirname "$0")

cp $sd/update_files.sh $wd
chown chris:chris update_files.sh

echo "script_dir=$sd" > .os_test_vars_default

./update_files.sh