#! /bin/bash
export SYSTEM_VERSION_COMPAT=1

# instructions on compiling numpy from source  here: https://numpy.org/doc/stable/user/building.html

# spack environment 
. spack/share/spack/setup-env.sh
spack env create lab03_spack_3 lab03_spack.yaml
spack env activate lab03_spack_3
spack concretize
echo $(spack find -c)
spack install
spack env loads -r
echo $(which gcc)

# make numpy
make numpy

# test numpy 
python3 -c 'import numpy; print(numpy.pi);'