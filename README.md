# quantum

This repo contains several examples of Quantum ... just for fun.

## qiskit-myqlm-1

An image generator based on qiskit and myqlm

![qiskit-myqlm-1](images/qiskit-myqlm-1.png?raw=true "qiskit-myqlm-1")

```
# Make sure to get qiskit, myqlm, myqlm-interop, tk ...
$ python3 ./qiskit-myqlm-1.py

```

You can also use the Dockerfile provided:

```
$ docker build -t qiskit-myqlm-1:latest -f ./Dockerfile.qiskit-myqlm-1
```

You can also use it in JARVICE:

```
podman build -t qiskit-myqlm-1:jarvice -f ./Dockerfile.gui --format docker
...tag...
...push...

# then add it as a custom app
```