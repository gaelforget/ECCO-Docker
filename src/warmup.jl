
import CairoMakie, Downloads, IJulia, Pkg, Pluto
import MITgcm, Climatology, Drifters

build_ECCO_setup=false
more_downloads=false

##

MITgcm.set_environment_variables_to_default()
MITgcm.system_check()

##

if build_ECCO_setup

p0=pathof(MITgcm)
fil=joinpath(dirname(p0),"..","examples","configurations","OCCA2.toml")
MC=MITgcm.MITgcm_config(inputs=MITgcm.read_toml(fil))
push!(MC.inputs[:setup][:main],(:input_folder => tempname()))
MITgcm.setup(MC)
MITgcm.build(MC)

cp(joinpath(dirname(p0),"..","examples","configurations","ECCO4.toml"),"src/ECCO4.toml")
cp(joinpath(dirname(p0),"..","examples","configurations","OCCA2.toml"),"src/OCCA2.toml")
cp(joinpath(MC,"MITgcm/mysetups/ECCOv4/input/download_files.jl"),"src/download_files.jl")

f=joinpath(MC,"MITgcm/mysetups/ECCOv4/build/mitgcmuv")
isfile(f) ? mv(f,"src/mitgcmuv") : println("mitgcmuv not found")
rm(pathof(MC),recursive=true)

end

##

tmp=MITgcm.ModelConfig(model=MITgcm.ClimateModels.RandomWalker)
MITgcm.setup(tmp)
MITgcm.launch(tmp) 

##

if more_downloads

MITgcm.MeshArrays.GRID_LLC90_download()

Downloads.download(
  "https://zenodo.org/record/5784905/files/interp_coeffs_halfdeg.jld2",
  joinpath(Climatology.ScratchSpaces.ECCO,"interp_coeffs_halfdeg.jld2");
  timeout=60000.0)

end#more_downloads

##

if more_downloads

Climatology.ECCOdiags_add("release2")
#Climatology.ECCOdiags_add("release4")

import MITgcm.ClimateModels.git

pth=joinpath(ENV["HOME"],"src","Climatology.jl")
run(`$(git()) clone https://github.com/JuliaOcean/Climatology.jl $pth`)
nb=joinpath(pth,"examples/ECCO/ECCO_standard_plots.jl")
Pluto.activate_notebook_environment(nb)
Pkg.instantiate()
include(nb)
Pkg.activate()

end#more_downloads

