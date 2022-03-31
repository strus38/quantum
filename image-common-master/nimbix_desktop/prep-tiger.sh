#!/bin/bash

VERSION=1.10.1
ARCH=$(arch)

# update links as needed
#TIGERVNC="https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-$VERSION.$ARCH.tar.gz"
TIGERVNC="https://storage.googleapis.com/app_archive/tigervnc/tigervnc-$VERSION.$ARCH.tar.gz"

# Grab tarballs on x86_64, install in place to an location that needs pathing
cd /usr/local/lib/nimbix_desktop
wget --content-disposition "$TIGERVNC"
