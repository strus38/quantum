#!/usr/bin/env bash

set -e
set -x

ARCH=$(arch)
BRANCH=master

while [ $# -gt 0 ]; do
  case $1 in
  --setup-nimbix-desktop)
    SETUP_NIMBIX_DESKTOP=1
    shift
    ;;
  --setup-realvnc)
    SETUP_REALVNC=1
    shift
    ;;
  --disable-desktop-autostart)
    export DISABLE_DESKTOP_AUTOSTART=1
    shift
    ;;
  --skip-os-pkg-update)
    export SKIP_OS_PKG_UPDATE=1
    shift
    ;;
  --skip-mpi-pkg)
    export SKIP_MPI_PKG=1
    shift
    ;;
  --image-common-branch)
    BRANCH=$2
    shift
    shift
    ;;
  *)
    break
    ;;
  esac
done

# Base OS
function setup_base_os() {
  PKGS="curl zip unzip sudo"

  # install EPEL first, successive packages live there
  dnf -y install epel-release

  # Packages to support MPI and basic container operation
  PKGS+=" passwd xz wget tar file openssh-server openssh-clients python3 python3-pip glibc-locale-source glibc-langpack-en"
  PKGS+=" which sshpass mailcap initscripts"
  if [[ -z $SKIP_MPI_PKG ]]; then
    PKGS+=" openmpi openmpi4 perftest"
    PKGS+=" dapl compat-dapl dapl.i686 compat-dapl.i686 infiniband-diags"
    PKGS+=" rdma-core rdma-core.i686 libibverbs libibverbs-utils"
  fi
  [ -z "$SKIP_OS_PKG_UPDATE" ] && dnf -y update
  dnf -y install $PKGS

  # Set locale
  localedef -i en_US -f UTF-8 en_US.UTF-8

  echo '# leave empty' >/etc/fstab
}

# Nimbix JARVICE emulation
function setup_jarvice_emulation() {
  /tmp/image-common-master/setup-nimbix.sh

  # Redundant directory copies, use a soft link, favor the /usr/local/ but
  #  J2 depends on this so allow the full copies for now
  mkdir -p /usr/lib/JARVICE
  cp -a /tmp/image-common-master/tools /usr/lib/JARVICE
  mkdir -p /usr/local/JARVICE
  cp -a /tmp/image-common-master/tools /usr/local/JARVICE
  #    ln -sf /usr/local/JARVICE /usr/lib/JARVICE
  cat <<'EOF' | tee /etc/profile.d/jarvice-tools.sh >/dev/null
JARVICE_TOOLS="/usr/local/JARVICE/tools"
JARVICE_TOOLS_BIN="$JARVICE_TOOLS/bin"
PATH="$PATH:$JARVICE_TOOLS_BIN"
export JARVICE_TOOLS JARVICE_TOOLS_BIN PATH
EOF

  cd /tmp
  mkdir -p /etc/JARVICE
  cp -a /tmp/image-common-master/etc/* /etc/JARVICE
  chmod 755 /etc/JARVICE
  mkdir -m 0755 /data
  chown nimbix:nimbix /data
}

function setup_nimbix_desktop() {
  mkdir -p /usr/local/lib/nimbix_desktop

  # Copy in the VNC server installers, both for CentOS, and the XFCE files
  files="install-centos-desktop.sh"
  files+=" install-centos-real.sh help-real.html"

  files+=" prep-tiger.sh install-tiger.sh help-tiger.html postinstall-desktop.sh"
  files+=" nimbix_desktop url.txt xfce4-session-logout share skel.config mimeapps.list helpers.rc"

  # Pull the files from the install bolus
  for i in $files; do
    cp -a /tmp/image-common-master/nimbix_desktop/"$i" \
      /usr/local/lib/nimbix_desktop
  done

  # Install RealVNC server on CentOS if requested, setup the desktop files

  /usr/local/lib/nimbix_desktop/install-centos-desktop.sh

  if [[ -n "$SETUP_REALVNC" ]]; then
    /usr/local/lib/nimbix_desktop/install-centos-real.sh
  fi

  if [[ $ARCH == x86_64 ]]; then
    /usr/local/lib/nimbix_desktop/prep-tiger.sh
  fi

  if [[ -z "$SETUP_REALVNC" ]]; then
    cp /usr/local/lib/nimbix_desktop/help-tiger.html /etc/NAE/help.html
  fi

  # clean up older copies, make a link for all apps to find nimbix_desktop
  rm -f /usr/lib/JARVICE/tools/nimbix_desktop
  ln -sf /usr/local/lib/nimbix_desktop/ /usr/lib/JARVICE/tools/nimbix_desktop

  # recreate nimbix user home to get the right skeleton files
  /bin/rm -rf /home/nimbix
  /sbin/mkhomedir_helper nimbix

  # Add a marker file for using a local, updated noVNC install
  echo /usr/local/JARVICE/tools/noVNC | sudo tee /etc/.novnc-stable
}

function cleanup() {
  dnf clean all
  rm -rf /tmp/image-common-master
}

setup_base_os
setup_jarvice_emulation
[ -n "$SETUP_NIMBIX_DESKTOP" ] && setup_nimbix_desktop
cleanup

exit 0