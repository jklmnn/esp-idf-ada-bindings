#!/usr/bin/env bash

set -e
set -u

basedir=$(pwd)/esp-idf

if [ ! -d $basedir ]
then
    git clone --recursive -b v5.0.3 https://github.com/espressif/esp-idf
fi

$basedir/install.sh esp32c3

# build a custom runtime based on the bare metal riscv32 runtime
unset HAL_ALIRE_PREFIX
RTS_DIR=$(alr exec -- riscv64-elf-gnatls --RTS=zfp-rv32imac -v | grep "gnat$" | head -n1 | xargs)
echo alr exec -- riscv64-elf-gnatls --RTS=zfp-rv32imac -v
echo src > $(pwd)/rts/ada_source_path
echo $RTS_DIR >> $(pwd)/rts/ada_source_path
alr exec -- gprbuild $(pwd)/rts/rts.gpr -XBASE=$RTS_DIR --target=riscv64-elf -v
