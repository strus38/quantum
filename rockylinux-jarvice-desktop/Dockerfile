ARG BASE_IMAGE
FROM ${BASE_IMAGE:-docker.io/rockylinux:latest}

USER root
RUN rm -rf /data

RUN dnf install -y ca-certificates && \
    curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/nimbix/jarvice-desktop/master/install-nimbix.sh | bash
#RUN /tmp/image-common-master/install-nimbix.sh --setup-nimbix-desktop --skip-mpi-pkg
