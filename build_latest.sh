#!/usr/bin/env bash

. .os_test_vars

sudo cp $os_dir/src/boot_sect.asm $tmp_dir/
sudo chown chris:chris $tmp_dir/boot_sect.asm
nasm -o boot_sect.bin $tmp_dir/boot_sect.asm