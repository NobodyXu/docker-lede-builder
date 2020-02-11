#!/bin/bash

cd ~/lede

./scripts/feeds update -a
./scripts/feeds install -a

make menuconfig

exec make -j $(nproc) V=s
