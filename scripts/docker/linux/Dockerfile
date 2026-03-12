# Minimal Ubuntu 24.04 image with SSH, SCP, and VI
FROM ubuntu:24.04

# Update package list and install essential packages
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    jq \
    openssh-server \
    openssh-client \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH
RUN mkdir /var/run/sshd && \
    echo 'root:password' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Create symbolic link for vi (if you prefer using vi command instead of vim)
RUN ln -s /usr/bin/vim /usr/bin/vi

# Expose port 22 inside the container
EXPOSE 22

# Start SSH daemon
CMD ["/usr/sbin/sshd", "-D"]