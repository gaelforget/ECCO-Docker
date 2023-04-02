
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/gaelforget/ECCO-Docker/HEAD)
[![DOI](https://zenodo.org/badge/507698620.svg)](https://zenodo.org/badge/latestdoi/507698620)

This [Docker image configuration](https://www.docker.com) makes it easy to analyze and run [ECCO](https://ecco-group.org) estimates and other [MITgcm](http://mitgcm.org) model solutions. 

It includes :

- [MITgcm](https://mitgcm.readthedocs.io/en/latest/?badge=latest) (67z) compiled for [ECCOv4](https://eccov4.readthedocs.io/en/latest/) (r2)
- gfortran, MPI, and NetCDF libraries for MITgcm
- Julia, R, Python, and Octave kernels for Jupyter
- Pluto notebook support (+ Jupyter + terminal)

## Directions

1. To use in the cloud

Click the binder link above.

2. To use on your local computer

You will need [Docker Desktop](https://docs.docker.com/desktop/) installed. 

Then, at the command line, try (2a)

```
docker run -p 8888:8888 gaelforget/ecco-docker
```

Or if you want to build your own image then try (2b)

```
git clone https://github.com/gaelforget/ECCO-Docker
docker build -t ecco-docker-1 ECCO-Docker
docker run -p 8888:8888 ecco-docker-1
```

## Preview 

In all cases (method 1, 2a, or 2b), the result should look like this in your web browser window :

![Screen Shot 2022-06-26 at 10 43 40 PM](https://user-images.githubusercontent.com/20276764/175850300-04fd85a4-45ac-4d88-8b32-91f585baa8cb.png)

_Note: this repository derives from the [JuliaClimate/Notebooks](https://github.com/JuliaClimate/Notebooks) Docker configuration._
