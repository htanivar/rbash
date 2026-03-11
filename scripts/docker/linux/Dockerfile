# Minimal Alpine Linux image
FROM alpine:latest

# Update package list and install essential packages if needed
RUN apk update && apk add --no-cache \
    bash \
    curl \
    && rm -rf /var/cache/apk/*

# Set a default command
CMD ["/bin/bash"]
