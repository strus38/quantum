# quantum

This repo contains several examples of Quantum ... just for fun.

References:

* [Jarvice](https://github.com/nimbix)
* [MyQLM](https://github.com/myqlm)
* [qiskit](https://qiskit.org/)

## Jarvice desktop container

Basic RockyLinux based image containing Jarvice desktop add-on.

```
cd rockylinux-jarvice-desktop
podman build -t rockylinux-nimbix-desktop -f ./Dockerfile --build-arg BASE_IMAGE=rockylinux:8.7
podman tag localhost/rockylinux-nimbix-desktop:latest 10.1.0.100:5000/jarvice/rockylinux-nimbix-desktop:latest
podman push 10.1.0.100:5000/jarvice/rockylinux-nimbix-desktop:latest
```

## myqlm

An image generator based on myqlm

![myqlm](images/myqlm.png?raw=true "myqlm")

```
cd myqlm
podman build -t myqlmapp:latest -f ./Dockerfile --build-arg BASE_IMAGE=10.1.0.100:5000/jarvice/rockylinux-nimbix-desktop:latest
podman tag localhost/myqlmapp:latest 10.1.0.100:5000/jarvice/root.myqlm.app:latest
podman push 10.1.0.100:5000/jarvice/root.myqlm.app:latest
```
## Jarvice

* Connect to the UI, add the new container `10.1.0.100:5000/jarvice/root.myqlm.app:latest` to the Push2Compute app.
* Launch the application, enjoy!
![myqlm](images/jarvice.png?raw=true "myqlm")


