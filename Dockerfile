FROM quay.io/centos/centos:stream8

RUN dnf install -y epel-release
RUN dnf install -y git pykickstart isomd5sum python2 createrepo sshpass debootstrap
RUN git clone https://opendev.org/openstack/octavia -b master /root/octavia
RUN chmod +x /root/octavia/diskimage-create/diskimage-create.sh
RUN cd /root/octavia/diskimage-create
RUN ./diskimage-create.sh
RUN cp /root/octavia/diskimage-create/amphora-x64-haproxy.qcow2 /root/amphora-x64-haproxy.qcow2