using ClimateModels, MITgcm, OceanStateEstimation
using Pluto, PlutoUI, PlutoSliderServer, Downloads, IJulia
#import Plots
import CairoMakie

p0=pathof(MITgcm)
fil=joinpath(dirname(p0),"..","examples","configurations","OCCA2.toml")
MC=MITgcm_config(inputs=read_toml(fil))
setup(MC)
build(MC)

mv(joinpath(MC,"MITgcm/mysetups/ECCOv4/build/mitgcmuv"),"mitgcmuv")
rm(pathof(MC),recursive=true)

tmp=ModelConfig(model=ClimateModels.RandomWalker)
setup(tmp)
launch(tmp) 

notebook_url="https://raw.githubusercontent.com/gaelforget/OceanStateEstimation.jl/master/examples/ECCO/ECCO_standard_plots.jl"
path_to_notebook = Downloads.download(notebook_url)
#include(path_to_notebook)

