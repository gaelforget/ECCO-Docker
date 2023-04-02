
This [Docker image configuration](https://www.docker.com) makes it easy to reproduce the [ECCO v4r4](https://ecco-group.org) state estimate.

It includes :

- [MITgcm](https://mitgcm.readthedocs.io/en/latest/?badge=latest) (67z) compiled for [ECCO v4r4]
- gfortran, MPI, and NetCDF libraries for MITgcm

## Directions

2. To use on your local computer

You will need [Docker Desktop](https://docs.docker.com/desktop/) installed. 

To build your own image, go into the directory ECCO-Docker/ECCO_v4r4 and run

```
docker build -t ecco_v4r4_docker_image .
```

To run the image do

```
docker run -t -i --rm ecco-v4r4-docker_image bash
```

After running you will be in an interactive bash shell.  To compile the code you'll need to choose or modify a SIZE.h file located in
```
/home/ecco/ECCOV4/release4/code
``` 

Then from the ```/home/ecco/ECCOV4/release4/build``` directory: 

```
>$ROOTDIR/tools/genmake2 -mods=../code -of=~/docker_src/linux_amd64_gfortran -mpi
>make -j depend
>make -j
``` 

To run the model you will need to link all the binary files as described here:

Instructions for reproducing ECCO Version 4 Release 4
[https://doi.org/10.5281/zenodo.7789915](https://doi.org/10.5281/zenodo.7789915)




