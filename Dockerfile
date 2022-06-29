FROM mas.ops.maap-project.org/root/jupyter-image/vanilla:develop

USER root

RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.2-linux-x86_64.tar.gz && \
    tar -xvzf julia-1.7.2-linux-x86_64.tar.gz && \
    mv julia-1.7.2 /opt/ && \
    ln -s /opt/julia-1.7.2/bin/julia /usr/local/bin/julia && \
    rm julia-1.7.2-linux-x86_64.tar.gz

ENV mainpath /usr/local/etc/gf
RUN mkdir -p ${mainpath}

COPY ./src ${mainpath}/src
COPY ./src/plutoserver ${mainpath}/plutoserver

RUN cp ${mainpath}/src/setup.py ${mainpath}/setup.py
RUN cp ${mainpath}/src/runpluto.sh ${mainpath}/runpluto.sh
# RUN cp ${mainpath}/src/Project.toml ${mainpath}/Project.toml
RUN cp ${mainpath}/src/build_MITgcm_ECCO.sh ${mainpath}/build_MITgcm_ECCO.sh
 
ENV JULIA_PROJECT ${mainpath}
ENV JULIA_DEPOT_PATH ${mainpath}/.julia

RUN conda config --env --add channels conda-forge
RUN conda config --env --add channels r
# RUN conda install -q numpy xarray dask pandas rise octave_kernel texinfo r-irkernel
# RUN julia -e "import Pkg; Pkg.Registry.update(); Pkg.instantiate();"

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential && \
    apt-get install -y --no-install-recommends vim && \
    apt-get install -y --no-install-recommends git && \
    apt-get install -y --no-install-recommends unzip && \
    apt-get install -y --no-install-recommends gfortran && \
    apt-get install -y --no-install-recommends openmpi-bin && \
    apt-get install -y --no-install-recommends openmpi-doc && \
    apt-get install -y --no-install-recommends libopenmpi-dev && \
    apt-get install -y --no-install-recommends mpich && \
    apt-get install -y --no-install-recommends libnetcdf-dev && \
    apt-get install -y --no-install-recommends libnetcdff-dev && \
#   apt-get install -y --no-install-recommends octave && \
#   apt-get install -y --no-install-recommends octave-doc && \
#   apt-get install -y --no-install-recommends octave-info && \
#   apt-get install -y --no-install-recommends octave-htmldoc && \
#   apt-get install -y --no-install-recommends liboctave-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# RUN jupyter labextension install @jupyterlab/server-proxy && \
#     jupyter lab build && \
#     jupyter lab clean && \
#     pip install ${mainpath} --no-cache-dir && \
#     rm -rf ~/.cache

# RUN julia --project=${mainpath} -e "import Pkg; Pkg.instantiate();"
# RUN julia ${mainpath}/src/download_stuff.jl

ENV MPI_INC_DIR /usr/lib/x86_64-linux-gnu/openmpi/include
RUN git clone --depth 1 --branch checkpoint67z https://github.com/MITgcm/MITgcm
RUN git clone https://github.com/gaelforget/ECCOv4
RUN mkdir MITgcm/mysetups
RUN mv ECCOv4 MITgcm/mysetups/.
RUN cd MITgcm/mysetups/ECCOv4/build
RUN ../../../tools/genmake2 -mods=../code -mpi > tmp.genmake.txt
RUN make depend > tmp.makedepend.txt
RUN make -j 4 > tmp.make.txt

RUN cd ${mainpath}

