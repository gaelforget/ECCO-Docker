
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/gaelforget/ECCO-Docker/HEAD)
[![DOI](https://zenodo.org/badge/507698620.svg)](https://zenodo.org/badge/latestdoi/507698620)

This [Docker image configuration](https://www.docker.com) makes it easy to analyze and run [NASA / ECCO](https://ecco-group.org) ocean state estimates and other [MITgcm](http://mitgcm.org) model solutions. It derives from the [JuliaClimate/Notebooks](https://github.com/JuliaClimate/Notebooks) Docker configuration and includes :

- [MITgcm](https://mitgcm.readthedocs.io/en/latest/?badge=latest) (67z) compiled for [ECCOv4](https://eccov4.readthedocs.io/en/latest/) (r2)
- gfortran, mpi, and netcdf libraries for MITgcm
- Julia, R, and Python kernels (for Jupyter notebooks)
- Support for Pluto notebook (+ Jupyter + terminal)

_Work in progress..._

To build and run locally, you will need [Docker Desktop](https://docs.docker.com/desktop/) installed. Then, at the command line, try :

```
docker build -t ecco-docker-1 .
docker run -p 8888:8888 ecco-docker-1
```

The result should look like this in your web browser window :

![Screen Shot 2022-06-26 at 10 43 40 PM](https://user-images.githubusercontent.com/20276764/175850300-04fd85a4-45ac-4d88-8b32-91f585baa8cb.png)
