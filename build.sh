#!/bin/bash

tar -xvf Python-3.8.10.tar.xz
tar -zxvf pykdump-3.5.3.tgz
tar -zxvf crash-7.3.0.tar.gz

root_dir=`pwd`
python_src=${root_dir}/Python-3.8.10
pykdump_src=${root_dir}/pykdump-3.5.3
crash_src=${root_dir}/crash-7.3.0

#build python
cd ${python_src}
./configure CFLAGS=-fPIC --disable-shared
cp ${pykdump_src}/Extension/Setup.local-3.8 Modules/Setup.local
make
strip --strip-debug libpython3.8.a

#build crash
cd ${crash_src}
make

#build pykdump
cd ${pykdump_src}/Extension
./configure -p ${python_src} -c ${crash_src}
make

cp ${pykdump_src}/Extension/mpykdump.so ${root_dir}/
