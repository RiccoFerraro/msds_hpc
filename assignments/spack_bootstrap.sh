#!/usr/bin/env bash

cd $WORK
git clone -c feature.manyFiles=true https://github.com/spack/spack.git
#  Do for each new shell or add to shell configuration
module purge
module load gcc-9.2 python-3.8.6-gcc-9.2.0-6pic63r
export SPACK_PYTHON=$(which python3)
source $WORK/spack/share/spack/setup-env.sh
# End do
spack compiler find
spack compilers
