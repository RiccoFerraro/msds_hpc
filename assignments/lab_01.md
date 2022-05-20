# LAB 1: Ricco Ferraro


##Peer Review: 

### Progress: 
I paired with Liaho. He seemed to have the spack.yaml file together, but hadn't tried executing it in M2 yet. I was in a similar position. 
### Problems: 
I had issues with getting my own custom Yaml working. When I just coppied the one (and slightly modified) from class it behaved correctly 
### Ideas: 
Maybe running a matrix of all compilers packages and targets is inefficient? 



## Steps to get Spack working in M2: 
1. use VIM to make spack_bootstrap.sh with the following contents: 

```
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

```

2. Use chmod to change the permissions of that shell by running: 

```
chmod u+x spack_bootstrap.sh
```

3. Run the created shell file to bootstrap spack 
```
./spack_bootstrap.sh
```

4. Test your installation with the following command: 
```
./spack/bin/spack -h
```

5. Create a `spack.yaml` file using VIM and the following contents: 

```
spack:
  config:
    install_missing_compilers: true
  view: true 
  definitions:
  - compilers: [gcc@10.3.0, gcc@11.2.0]
  - packages: [openblas threads=openmp, python@3.8.12, py-numpy+blas+lapack+matplotlib+pandas]
  - targets: [target=broadwell, target=zen2, target=x86_64_v3]
  specs:
  - matrix:
    - [$%compilers]
    - [$packages]
    - [$targets]

```

6. To ensure shell support from spack use the following command: 
```
. spack/share/spack/setup-env.sh
```

6. Create a spack environment by running the following command: 

```
spack env create msds spack.yml
```

7. Activate that environment via: 
```
spack env activate msds
```
