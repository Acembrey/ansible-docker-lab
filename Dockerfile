# Dockerfile
FROM rockylinux/rockylinux:8.10-minimal

# Install base tools (microdnf is available on -minimal)
# Includes: SSH server/clients, Python3 (for Ansible), sudo, and handy utilities
RUN microdnf -y clean all && rm -rf /var/yum/cache && microdnf -y makecache --refresh \
      && microdnf -y install \
      openssh-server openssh-clients sudo python3 \
      iproute iputils procps-ng net-tools nmap-ncat bind-utils \
      vim-minimal nano less curl wget tar gzip unzip which \
  && microdnf -y clean all \
  && rm -rf /var/cache/yum

# SSH hardening knobs for a lab: allow root + password auth (lab-only!)
RUN sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    mkdir -p /var/run/sshd

# Create a sudo user (wheel) — override at build with --build-arg
ARG USERNAME=appuser
ARG PASSWORD=Admin@123
RUN useradd -m -s /bin/bash ${USERNAME} \
  && echo "${USERNAME}:${PASSWORD}" | chpasswd \
  && echo "root:${PASSWORD}" | chpasswd \
  && usermod -aG wheel ${USERNAME}

# Working dir for lab files
WORKDIR /appdata
RUN chown -R ${USERNAME}:${USERNAME} /appdata

# Simple entrypoint: generate host keys if missing, then run sshd in foreground
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 22
ENTRYPOINT ["/bin/sh","-c","ssh-keygen -A >/dev/null 2>&1 || true; exec /usr/sbin/sshd -D -e"]
