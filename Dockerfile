FROM jupyter/base-notebook:latest

USER root

ENV mainpath ./
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
    apt-get install -y --no-install-recommends libnetcdff-dev

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
 
ENV USER_HOME_DIR /home/${NB_USER}
RUN echo 'alias julia="${USER_HOME_DIR}/.juliaup/bin/julia"' >> ~/.bashrc

RUN conda config --env --add channels conda-forge
RUN conda config --env --add channels r
RUN conda install numpy xarray
RUN conda install dask pandas
RUN conda install octave_kernel texinfo r-irkernel

RUN curl -fsSL https://install.julialang.org | sh -s -- --yes

RUN ${USER_HOME_DIR}/.juliaup/bin/julia --project=${mainpath} -e "import Pkg; Pkg.instantiate();"
RUN ${USER_HOME_DIR}/.juliaup/bin/julia --project=${mainpath} ${mainpath}/src/warmup.jl
RUN ${USER_HOME_DIR}/.juliaup/bin/julia --project=${mainpath} ${mainpath}/src/download_stuff.jl

ENV MPI_INC_DIR /usr/lib/x86_64-linux-gnu/openmpi/include

RUN jupyter lab build && \
    jupyter lab clean && \
    pip install ${mainpath} --no-cache-dir && \
    rm -rf ~/.cache


