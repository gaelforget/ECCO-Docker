
## pyDataverse

using PyCall, Conda, Pkg

ENV["PYTHON"]=""
Pkg.build("PyCall")

Conda.pip_interop(true)
Conda.pip("install", "pyDataverse")

##

using PlutoSliderServer, ClimateModels
pth=dirname(pathof(ClimateModels))

fil=joinpath(pth,"..","examples","MITgcm.jl")
PlutoSliderServer.export_notebook(fil)

