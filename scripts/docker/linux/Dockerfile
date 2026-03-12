# Minimal Ubuntu 24.04 image with SSH, SCP, and VI
FROM ubuntu:24.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install essential packages
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    jq \
    openssh-server \
    openssh-client \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH
RUN mkdir /var/run/sshd && \
    echo 'root:password' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/' /etc/ssh/sshd_config

# Remove and Create symbolic link for vi
RUN rm -f /usr/bin/vi && ln -s /usr/bin/vim /usr/bin/vi

# Create a simple startup script
RUN echo '#!/bin/bash\n/usr/sbin/sshd -D' > /start.sh && chmod +x /start.sh

# Expose port 22 inside the container
EXPOSE 22

# Start SSH daemon (using the script)
CMD ["/start.sh"]