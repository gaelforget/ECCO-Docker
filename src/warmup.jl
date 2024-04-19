using Pluto, CairoMakie, Downloads, IJulia, Pkg

import MITgcm, OceanStateEstimation
import MITgcm.ClimateModels
import MITgcm.MeshArrays
using MITgcm.ClimateModels.Git

##

p0=pathof(MITgcm)
fil=joinpath(dirname(p0),"..","examples","configurations","OCCA2.toml")
MC=MITgcm.MITgcm_config(inputs=MITgcm.read_toml(fil))
ClimateModels.setup(MC)
ClimateModels.build(MC)

mv(joinpath(MC,"MITgcm/mysetups/ECCOv4/build/mitgcmuv"),"mitgcmuv")
rm(pathof(MC),recursive=true)

##

tmp=ClimateModels.ModelConfig(model=ClimateModels.RandomWalker)
ClimateModels.setup(tmp)
ClimateModels.launch(tmp) 

##

MeshArrays.GRID_LLC90_download()
OceanStateEstimation.ECCOdiags_add("release2")
OceanStateEstimation.ECCOdiags_add("release4")

Downloads.download(
  "https://zenodo.org/record/5784905/files/interp_coeffs_halfdeg.jld2",
  joinpath(OceanStateEstimation.ScratchSpaces.ECCO,"interp_coeffs_halfdeg.jld2");
  timeout=60000.0)

##

run(`$(git()) clone https://github.com/gaelforget/OceanStateEstimation.jl`)
nb=joinpath(ENV["HOME"],"OceanStateEstimation.jl/examples/ECCO/ECCO_standard_plots.jl")
Pluto.activate_notebook_environment(nb)
Pkg.instantiate()
include(nb)
Pkg.activate()

