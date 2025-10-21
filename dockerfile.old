# Dockerfile
FROM ubuntu:22.04

# Install SSH and useful tools
RUN apt update && apt install -y openssh-server sudo vim curl net-tools netcat wget less

# Enable root login and create a sudo user
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN useradd -m -s /bin/bash appuser && echo "appuser:Admin@123" | chpasswd
RUN usermod -aG sudo appuser

# Setup working directory
WORKDIR /appdata
RUN chown -R appuser:appuser /appdata

# Expose SSH
EXPOSE 22
ENTRYPOINT service ssh start && bash
