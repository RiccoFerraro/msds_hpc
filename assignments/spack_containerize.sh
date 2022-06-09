#!/usr/bin/env sh

# Define the Spack environment
cat spack.yaml

. spack/share/spack/setup-env.sh

# Build container definition file
spack containerize > Dockerfile

# Build the container image
docker build --no-cache -t lab02:riccoferraro .

