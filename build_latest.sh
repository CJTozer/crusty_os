#!/usr/bin/env bash

. .os_test_vars

for f in $(sudo ls $os_dir/boot/)
do
    sudo cp $os_dir/boot/$f $tmp_dir/
    sudo chown chris:chris $tmp_dir/$f
    echo $f
done

nasm -I$tmp_dir -o boot_sect.bin $tmp_dir/boot_sect.asm