## Peer Review
Worked with Jon Pugh through some confusion on what we were expected to write a makefile for. I had previously thought that we were going to write makefiles whcih handled all the building of individual c++ modules, and that got overwhelming very fast for numpy which is a complicated package with a combination of c, c++, fortran, etc. It was relieving to hear that we didn't need to do that. Ultimately, I used make to orchestrate calls to numpy's local build process (which involves cloning numpy and running their setup.py with gcc/f77 present)

## How to use spack, docker, and make to build numpy locally (compiler flags optional)

Spack Contanerize was used to build a docker file, which was then modified to create a build environment for numpy. 
This was done to make sure that local installations of things like fortran compilers don't cause inconsistencies or problems. 

To Generate the Dockerfile in question: 
First: 
1. Run `git clone -c feature.manyFiles=true https://github.com/spack/spack.git` from the terminal 
2. Run `./spack_to_docker.sh` to generate a dockerfile
3. Add a `spack.yaml` file to this directory with the following contents: 
    ```
    spack:
    specs:
    - gcc@10.3.0
    - python@3.8.12
    - py-pandas
    - py-matplotlib
    - py-numpy+blas+lapack
    - py-cython
    - openblas
    concretization: together
    container:
        format: docker
        images:
        os: ubuntu:18.04
        spack: v0.17.2
        os_packages:
        final:
        - libgfortran4
        - libgomp1
        extra_instructions:
        final:
            RUN cd /opt/view/bin; find . -xtype l -exec sh -c 'ln -f -s $(basename $(readlink $0)) $(basename $0)' {} \;
    ```

4. Create a shell script `lab03_docker.sh` with the following contents: 
    ```
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
    ```
5. Add the following to the dockerfile: 

    ```
    # I Added these lines to install git, pip, dev python3.8, setuptools, disttools, etc
    RUN apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y git

    RUN  git config --global --add safe.directory /numpy

    RUN apt-get -y install python3.8-distutils
    RUN apt-get -y install python3-setuptools
    RUN apt-get -y install python3.8-dev
    RUN apt-get -y install python3-pip

    COPY Makefile Makefile
    COPY lab03_docker.sh lab03_docker.sh
    RUN chmod u+x lab03_docker.sh
    ```
6. build the dockerfile by running `docker build . ricco:lab03`

### Running in Docker
1. `docker exec -it ricco:lab03`
2. Type `bash` into the terminal that starts inside the above docker container to run bash 
3. type `./lab03_docker.sh` into the terminal to build numpy (this clones and configures the dev numpy calls the make file)
4. This should compile numpy with the fortan and gcc compilers that were included via spack in the docker image created above. 
5. The result looks like this:

```INFO: CCompilerOpt.cache_flush[857] : write cache to path -> /numpy/build/temp.linux-x86_64-3.8/ccompiler_opt_cache_ext.py
INFO: 
########### CLIB COMPILER OPTIMIZATION ###########
INFO: Platform      : 
  Architecture: x64
  Compiler    : gcc

CPU baseline  : 
  Requested   : 'min'
  Enabled     : SSE SSE2 SSE3
  Flags       : -msse -msse2 -msse3
  Extra checks: none

CPU dispatch  : 
  Requested   : 'max -xop -fma4'
  Enabled     : SSSE3 SSE41 POPCNT SSE42 AVX F16C FMA3 AVX2 AVX512F AVX512CD AVX512_KNL AVX512_KNM AVX512_SKX AVX512_CNL
  Generated   : none
INFO: CCompilerOpt.cache_flush[857] : write cache to path -> /numpy/build/temp.linux-x86_64-3.8/ccompiler_opt_cache_clib.py
./lab03_docker.sh: line 24: python: command not found
root@cafae30f7cd8:/# ```

6. To Test your numpy installation: type `python3.8 -c 'import nuumpy; print(numpy.pi)'`