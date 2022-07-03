#! /bin/bash
export SYSTEM_VERSION_COMPAT=1

# instructions on compiling numpy from source  here: https://numpy.org/doc/stable/user/building.html

# spack environment 
echo $(which gcc)


git clone https://github.com/numpy/numpy.git
cd numpy 
git submodule update --init
cd .. 

python3.8 -m pip install cython
python3.8 -m pip install ./numpy



# make numpy
make numpy

# test numpy 
python -c 'import numpy; print(numpy.pi);'