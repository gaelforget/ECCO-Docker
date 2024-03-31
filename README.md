![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/gaelforget/ECCO-Docker/HEAD)
[![DOI](https://zenodo.org/badge/507698620.svg)](https://zenodo.org/badge/latestdoi/507698620)

This [Docker image configuration](https://www.docker.com) makes it easy to analyze and run [ECCO](https://ecco-group.org) estimates and other [MITgcm](http://mitgcm.org) model solutions. 

It includes :

- [MITgcm](https://mitgcm.readthedocs.io/en/latest/?badge=latest) (version 68o) compiled for [ECCO4](https://eccov4.readthedocs.io/en/latest/)
- gfortran, MPI, and NetCDF libraries for MITgcm
- Julia, R, Python, and Octave kernels for Jupyter
- Notebook support (Jupyter and Pluto)

## Directions

🎦 [video tutorial](https://www.youtube.com/live/daNrJhPPgWg?si=C2SXKgeh3AMzwW2a) 🎦

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

![Screen Shot 2022-06-26 at 10 43 40 PM](https://private-user-images.githubusercontent.com/20276764/318265855-b51bb390-c127-4a1a-93e9-6fcf75331e60.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MTE4ODc1NzcsIm5iZiI6MTcxMTg4NzI3NywicGF0aCI6Ii8yMDI3Njc2NC8zMTgyNjU4NTUtYjUxYmIzOTAtYzEyNy00YTFhLTkzZTktNmZjZjc1MzMxZTYwLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDAzMzElMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwMzMxVDEyMTQzN1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWUwNmFmOWE4Y2YwZmYwZjk0MDY4ZWE2MTFkYjU4Y2M0YTQ5MmEyZTExNThmYTQwMmI3YWQwMmEzNGVlOGVhNzQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.1NZm6frwr81hBrbUGGbNXHYQEyojCNTg2Zul9b3YvZc)

_Note: this repository derives from the [JuliaClimate/Notebooks](https://github.com/JuliaClimate/Notebooks) Docker configuration._
