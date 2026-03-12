# Minimal Ubuntu 24.04 image with SSH
FROM ubuntu:24.04

# Update package list and install essential packages
RUN apk update && apk add --no-cache \
    bash \
    curl \
    jq \
    openssh \
    && rm -rf /var/cache/apk/*

# Configure SSH
RUN ssh-keygen -A && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

# Set root password (change 'root' to your desired password)
RUN echo "root:root" | chpasswd

# Expose SSH port
EXPOSE 22

# Start SSH daemon and keep container running
CMD ["/usr/sbin/sshd", "-D"]
