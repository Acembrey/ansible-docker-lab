# Dockerfile
FROM rockylinux/rockylinux:8.10-minimal

# Install base tools (microdnf is available on -minimal)
# Got a bad mirror on first build, so wipe and rebuild cache, then install packages 
RUN microdnf -y clean all && rm -rf /var/yum/cache && microdnf -y makecache --refresh \
      && microdnf -y install \
      openssh-server openssh-clients sudo python3 \
      iproute iputils procps-ng net-tools nmap-ncat bind-utils \
      vim-minimal nano less curl wget tar gzip unzip which \
  && microdnf -y clean all \
  && rm -rf /var/cache/yum

# SSH hardening knobs for a lab: allow root + password auth
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

# Expose port 22 
EXPOSE 22

# SSHD get run in the foreground as PID 1, if it dies, so does the container. This could be changed, but honestly if you can't ssh in, no ansible.
# Below generates host ssh keys if they don't exists, and starts sshd
ENTRYPOINT ["/bin/sh","-c","ssh-keygen -A >/dev/null 2>&1 || true; exec /usr/sbin/sshd -D -e"]
