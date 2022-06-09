# Build stage with Spack pre-installed and ready to be used
FROM spack/ubuntu-bionic:v0.17.2 as builder


# What we want to install and how we want to install it
# is specified in a manifest file (spack.yaml)
RUN mkdir /opt/spack-environment \
&&  (echo "spack:" \
&&   echo "  specs:" \
&&   echo "  - python@3.8.12" \
&&   echo "  - py-pandas" \
&&   echo "  - py-matplotlib" \
&&   echo "  - py-numpy+blas+lapack" \
&&   echo "  - openblas threads=openmp" \
&&   echo "  concretization: together" \
&&   echo "  config:" \
&&   echo "    install_tree: /opt/software" \
&&   echo "  view: /opt/view") > /opt/spack-environment/spack.yaml

# Install the software, remove unnecessary deps
RUN cd /opt/spack-environment && \
    spack env activate . && \
    spack install --fail-fast && \
    spack gc -y

# Strip all the binaries
RUN find -L /opt/view/* -type f -exec readlink -f '{}' \; | \
    xargs file -i | \
    grep 'charset=binary' | \
    grep 'x-executable\|x-archive\|x-sharedlib' | \
    awk -F: '{print $1}' | xargs strip -s

# Modifications to the environment that are necessary to run
RUN cd /opt/spack-environment && \
    spack env activate --sh -d . >> /etc/profile.d/z10_spack_environment.sh

# Bare OS image to run the installed executables
FROM ubuntu:18.04

COPY --from=builder /opt/spack-environment /opt/spack-environment
COPY --from=builder /opt/software /opt/software
COPY --from=builder /opt/view /opt/view
COPY --from=builder /etc/profile.d/z10_spack_environment.sh /etc/profile.d/z10_spack_environment.sh

RUN apt-get -yqq update && apt-get -yqq upgrade \
 && apt-get -yqq install libgfortran4 libgomp1 \
 && rm -rf /var/lib/apt/lists/*

RUN cd /opt/view/bin; find . -xtype l -exec sh -c 'ln -f -s $(basename $(readlink $0)) $(basename $0)' {} \;
ENTRYPOINT ["/bin/bash", "--rcfile", "/etc/profile", "-l"]

