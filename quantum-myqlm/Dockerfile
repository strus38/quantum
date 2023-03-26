ARG BASE_IMAGE
FROM ${BASE_IMAGE:-docker.io/rockylinux:latest}

USER root
RUN rm -rf /data

RUN dnf install epel-release tk curl -y && dnf --enablerepo=epel group
RUN python3 -m pip install --upgrade pip
RUN dnf install python3-pip python3-tkinter -y
RUN pip3 install cython cmake scikit-build myqlm qiskit myqlm-interop

COPY NAE/myqlm.png /etc/NAE/screenshot.png
COPY NAE/AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://cloud.nimbix.net/api/jarvice/validate

RUN mkdir -p /etc/NAE && touch /etc/NAE/{screenshot.png,screenshot.txt,license.txt,AppDef.json}

# Commands to run application
COPY myqlm.py /tmp/myqlm.py
RUN chmod 777 /tmp/myqlm.py

CMD ["/tmp/myqlm.py"]
ENTRYPOINT ["python3"]
