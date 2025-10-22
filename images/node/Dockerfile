# Specify image to use
FROM rockylinux/rockylinux:8.10

# Use dnf to upgrade and install packages
RUN dnf -y update && dnf -y install \
      openssh-server openssh-clients sudo python3 \
      iproute iputils procps-ng net-tools nmap-ncat bind-utils \
      vim nano less curl wget tar gzip unzip which \
  && dnf -y clean all && mkdir -p /var/run/sshd

# Specify user and passwd to create on the image. (can be changed in .env)
ARG USERNAME=appuser
ARG PASSWORD=supersecret

# Create the user on the image. Set root pw same as user
RUN useradd -m -s /bin/bash "$USERNAME" && echo "$USERNAME:$PASSWORD" | chpasswd \
 && echo "root:$PASSWORD" | chpasswd && usermod -aG wheel "$USERNAME"

# configure sshd options (not really needed)
RUN sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config

WORKDIR /home/${USERNAME}

# Expose 22, set entry point to sshd
EXPOSE 22
ENTRYPOINT ["/bin/sh","-c","ssh-keygen -A >/dev/null 2>&1 || true; rm -f /run/nologin /etc/nologin; exec /usr/sbin/sshd -D -e"]
