ARG BASE_IMAGE
FROM ${BASE_IMAGE:-docker.io/rockylinux:latest}

USER root
RUN rm -rf /data

ADD ../qiskit-myqlm-1/image-common-master /tmp/image-common-master
RUN /tmp/image-common-master/install-nimbix.sh --setup-nimbix-desktop --skip-mpi-pkg
