FROM quay.io/centos/centos:stream8

RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
      dnf update -y

# Install python pip
RUN dnf install -y python2
# Eventually create a virtualenv
RUN dnf pip install -y virtualenv
RUN virtualenv octavia_disk_image_create
RUN source octavia_disk_image_create/bin/activate
# Install octavia requirements
RUN cd octavia/diskimage-create
RUN pip install -r requirements.txt

RUN dnf install -y pykickstart isomd5sum python2 createrepo sshpass debootstrap qemu-img git e2fsprogs policycoreutils-python-utils
RUN git clone https://opendev.org/openstack/octavia -b master /root/octavia
RUN chmod +x /root/octavia/diskimage-create/diskimage-create.sh
RUN /root/octavia/diskimage-create/diskimage-create.sh
CMD ["/bin/bash", "-l"]
#RUN cp /root/octavia/diskimage-create/amphora-x64-haproxy.qcow2 /root/amphora-x64-haproxy.qcow2