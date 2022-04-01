# quantum

This repo contains several examples of Quantum ... just for fun.

References:

* [Jarvice](https://github.com/nimbix)
* [MyQLM](https://github.com/myqlm)
* [qiskit](https://qiskit.org/)

## qiskit-myqlm-1

An image generator based on qiskit and myqlm

![qiskit-myqlm-1](images/qiskit-myqlm-1.png?raw=true "qiskit-myqlm-1")

```
# Make sure to get qiskit, myqlm, myqlm-interop, tk ...
$ cd qiskit-myqlm-1
$ python3 ./qiskit-myqlm-1.py

```

You can also use the Dockerfile provided:

```
$ cd qiskit-myqlm-1
$ docker build -t qiskit-myqlm-1:latest -f ./Dockerfile.qiskit-myqlm-1
```

You can also use it in JARVICE:

```
$ cd qiskit-myqlm-1
$ podman build -t qiskit-myqlm-1:jarvice -f ./Dockerfile.jarvice
...tag...
...push...

# then add it as a custom app
```

![qiskit-myqlm-1 with JARVICE](images/jarvice.JPG?raw=true "Jarvice")

## rockylinux-jarvice-desktop

Build a generic base container for a nimbix-desktop app using Rockylinux as a base image.