let 
    import MITgcm, Downloads

    url0="https://raw.githubusercontent.com/MITgcm/MITgcm/refs/heads/master/"
    url1=url0*"tools/build_options/linux_arm64_gfortran"
    url2=url0*"tools/genmake2"

    path0=MITgcm.default_path()
    path1=joinpath(path0,"tools","build_options","linux_arm64_gfortran")
    path2=joinpath(path0,"tools","genmake2")

    Downloads.download(url1,path1)
    Downloads.download(url2,path2)
end