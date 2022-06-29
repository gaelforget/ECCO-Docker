#!/bin/sh

git clone --depth 1 --branch checkpoint67z https://github.com/MITgcm/MITgcm
git clone https://github.com/gaelforget/ECCOv4

mkdir MITgcm/mysetups
mv ECCOv4 MITgcm/mysetups/.

#export MPI_INC_DIR=/usr/lib/x86_64-linux-gnu/openmpi/include

cd MITgcm/mysetups/ECCOv4/build
../../../tools/genmake2 -mods=../code -mpi > tmp.genmake.txt
make depend > tmp.makedepend.txt
make -j 4 > tmp.make.txt
cd ..

