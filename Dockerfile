FROM jupyter/base-notebook:latest

USER root

ENV mainpath /home/jovyan/
RUN mkdir -p ${mainpath}

RUN apt-get update

RUN apt-get install -y --no-install-recommends build-essential && \
    apt-get install -y --no-install-recommends vim && \
    apt-get install -y --no-install-recommends git && \
    apt-get install -y --no-install-recommends curl && \
    apt-get install -y --no-install-recommends unzip

RUN apt-get install -y --no-install-recommends gfortran && \
    apt-get install -y --no-install-recommends gnuplot && \
    apt-get install -y --no-install-recommends openmpi-bin && \
    apt-get install -y --no-install-recommends openmpi-doc && \
    apt-get install -y --no-install-recommends libopenmpi-dev && \
    apt-get install -y --no-install-recommends mpich && \
    apt-get install -y --no-install-recommends libnetcdf-dev && \
    apt-get install -y --no-install-recommends libnetcdff-dev && \
    apt-get install -y --no-install-recommends cmake

RUN apt-get install -y --no-install-recommends octave octave-doc && \
    apt-get install -y --no-install-recommends octave-io && \
    apt-get install -y --no-install-recommends octave-optim && \
    apt-get install -y --no-install-recommends octave-statistics && \
    apt-get install -y --no-install-recommends liboctave-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_USER}

COPY --chown=${NB_USER}:users ./src ${mainpath}/src
COPY --chown=${NB_USER}:users ./src/plutoserver ${mainpath}/plutoserver

RUN cp ${mainpath}/src/setup.py ${mainpath}/setup.py
RUN cp ${mainpath}/src/runpluto.sh ${mainpath}/runpluto.sh
RUN cp ${mainpath}/src/Project.toml ${mainpath}/Project.toml
 
RUN echo 'alias julia="${mainpath}/.juliaup/bin/julia --project=${mainpath}"' >> ~/.bashrc

RUN conda config --env --add channels conda-forge
RUN conda config --env --add channels r
RUN conda install numpy xarray pandas
RUN conda install octave_kernel texinfo r-irkernel

RUN curl -fsSL https://install.julialang.org | sh -s -- --yes

RUN ${mainpath}/.juliaup/bin/julia --project=${mainpath} -e "import Pkg; Pkg.instantiate();"
RUN ${mainpath}/.juliaup/bin/julia --project=${mainpath} ${mainpath}/src/warmup.jl

RUN jupyter lab build && \
    jupyter lab clean && \
    pip install ${mainpath} --no-cache-dir && \
    rm -rf ~/.cache

