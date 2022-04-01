# qiskit-myqlm-1

An image generator based on qiskit and myqlm.
It provides a standalone app, a container app, and a JARVICE app.

Example for JARVICE:

```
$ podman build -t qiskit-myqlm-1:jarvice -f ./Dockerfile.jarvice
...tag...
...push...

# then add it as a custom app
```

![qiskit-myqlm-1 with JARVICE](images/jarvice.JPG?raw=true "Jarvice")