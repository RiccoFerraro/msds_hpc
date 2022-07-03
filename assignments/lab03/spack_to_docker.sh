#!/usr/bin/env sh

# Define the Spack environment
cat spack.yaml

. spack/share/spack/setup-env.sh

# Build container definition file
spack containerize > Dockerfile


