using Pluto, CairoMakie, Downloads, IJulia, Pkg

import MITgcm, Climatology
import MITgcm.ClimateModels
import MITgcm.MeshArrays
using MITgcm.ClimateModels.Git

##

p0=pathof(MITgcm)
fil=joinpath(dirname(p0),"..","examples","configurations","OCCA2.toml")
MC=MITgcm.MITgcm_config(inputs=MITgcm.read_toml(fil))
push!(MC.inputs[:setup][:main],(:input_folder => tempname()))
ClimateModels.setup(MC)
ClimateModels.build(MC)

cp(joinpath(dirname(p0),"..","examples","configurations","ECCO4.toml"),"src/ECCO4.toml")
cp(joinpath(dirname(p0),"..","examples","configurations","OCCA2.toml"),"src/OCCA2.toml")
cp(joinpath(MC,"MITgcm/mysetups/ECCOv4/input/download_files.jl"),"src/download_files.jl")

mv(joinpath(MC,"MITgcm/mysetups/ECCOv4/build/mitgcmuv"),"src/mitgcmuv")
rm(pathof(MC),recursive=true)

##

tmp=ClimateModels.ModelConfig(model=ClimateModels.RandomWalker)
ClimateModels.setup(tmp)
ClimateModels.launch(tmp) 

##

MeshArrays.GRID_LLC90_download()
Climatology.ECCOdiags_add("release2")
Climatology.ECCOdiags_add("release4")

Downloads.download(
  "https://zenodo.org/record/5784905/files/interp_coeffs_halfdeg.jld2",
  joinpath(Climatology.ScratchSpaces.ECCO,"interp_coeffs_halfdeg.jld2");
  timeout=60000.0)

##

pth=joinpath(ENV["HOME"],"src","Climatology.jl")
run(`$(git()) clone https://github.com/gaelforget/Climatology.jl $pth`)
nb=joinpath(pth,"examples/ECCO/ECCO_standard_plots.jl")
Pluto.activate_notebook_environment(nb)
Pkg.instantiate()
include(nb)
Pkg.activate()

