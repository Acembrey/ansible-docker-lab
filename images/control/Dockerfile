FROM rockylinux/rockylinux:8.10
RUN dnf -y update && dnf -y install \
      python3 python3-pip git jq sshpass openssh-clients \
      ansible-core sudo vim nano which tar gzip unzip \
  && dnf -y clean all
WORKDIR /etc/ansible
ENTRYPOINT ["sleep","infinity"]
