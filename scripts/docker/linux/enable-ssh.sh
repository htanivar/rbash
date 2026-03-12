apk update && \
apk add openssh && \
ssh-keygen -A && \
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
passwd && \
/usr/sbin/sshd