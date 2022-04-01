# Rockylinux myqlm Jarvice application

## Description

This repo aims to provide a sample base image to a rockylinux jarvice-desltop application.

This image can then be used as a base image for any other myqlm application running in Jarvice

References:

* [Jarvice](https://github.com/nimbix)
* [MyQLM](https://github.com/myqlm)

## How to use

Build and push your Jarvice image

```
docker build -t rockylinux-nimbix-desktop -f ./Dockerfile --build-arg BASE_IMAgE=docker.io/rockylinux:latest
docker tag rockylinux-nimbix-desktop <myregistry>/rockylinux-nimbix-desktop:latest
docker push <myregistry>/rockylinux-nimbix-desktop:latest
```

Build you custom MyQLM image

```
docker build -t myapp -f ./Dockerfile.myqlmjarvice-app --build-arg BASE_IMAGE=<myregistry>/rockylinux-nimbix-desktop:latest
docker tag myapp <myregistry>/myapp:latest
docker push  <myregistry>/myapp:latest
```

Add the app to JARVICE XE 'push2compute' application