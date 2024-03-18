import MeshArrays, MITgcmTools, Downloads
MeshArrays.GRID_LLC90_download()

import OceanStateEstimation
OceanStateEstimation.ECCOdiags_add("release2")
OceanStateEstimation.ECCOdiags_add("release4")
#OceanStateEstimation.ECCOdiags_add("interp_coeffs")

Downloads.download(
  "https://zenodo.org/record/5784905/files/interp_coeffs_halfdeg.jld2",
  joinpath(OceanStateEstimation.ScratchSpaces.ECCO,"interp_coeffs_halfdeg.jld2");
  timeout=60000.0)

