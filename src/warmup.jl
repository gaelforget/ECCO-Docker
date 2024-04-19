using Pluto, PlutoUI, PlutoSliderServer, Downloads, IJulia
#import Plots
import CairoMakie

using ClimateModels, MITgcm, OceanStateEstimation, MeshArrays
##

p0=pathof(MITgcm)
fil=joinpath(dirname(p0),"..","examples","configurations","OCCA2.toml")
MC=MITgcm_config(inputs=read_toml(fil))
setup(MC)
build(MC)

mv(joinpath(MC,"MITgcm/mysetups/ECCOv4/build/mitgcmuv"),"mitgcmuv")
rm(pathof(MC),recursive=true)

##

tmp=ModelConfig(model=ClimateModels.RandomWalker)
setup(tmp)
launch(tmp) 

##

using ClimateModels.Git
run(`$(git()) clone https://github.com/gaelforget/OceanStateEstimation.jl`)

MeshArrays.GRID_LLC90_download()
OceanStateEstimation.ECCOdiags_add("release2")
OceanStateEstimation.ECCOdiags_add("release4")

Downloads.download(
  "https://zenodo.org/record/5784905/files/interp_coeffs_halfdeg.jld2",
  joinpath(OceanStateEstimation.ScratchSpaces.ECCO,"interp_coeffs_halfdeg.jld2");
  timeout=60000.0)

##

using Pkg
nb="OceanStateEstimation.jl/examples/ECCO/ECCO_standard_plots.jl"
Pluto.activate_notebook_environment(nb)
Pkg.instantiate()
include(nb)
Pkg.activate()

