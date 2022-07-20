#! /bin/bash
export SYSTEM_VERSION_COMPAT=1



# for running in m2 (not locally in docker)


##### # if no spack is installed yet, uncomment this

# git clone -c feature.manyFiles=true https://github.com/spack/spack.git
# #  Do for each new shell or add to shell configuration
# module purge
# module load gcc-9.2 python-3.8.6-gcc-9.2.0-6pic63r
# export SPACK_PYTHON=$(which python3)
# source $WORK/spack/share/spack/setup-env.sh
# # End do
# spack compiler find
# spack compilers

######
# in M2 Add this file, along with the Makefile listed in this directory. 
. spack/share/spack/setup-env.sh
spack create env assignment_05_gprof
spack env activate assignment_05_gprof
spack concretize
spack install

git clone https://github.com/numpy/numpy.git
cd numpy 
git submodule update --init
cd .. 

python3.8 -m ensurepip
python3.8 -m pip install ./numpy

# make numpy
make numpy

# test numpy 
python -c 'import numpy; print(numpy.pi);'