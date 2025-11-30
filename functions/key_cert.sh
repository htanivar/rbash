#!/bin/bash
# key_cert.sh - keys and certs utility functions for bash scripts

# =============================================================================
# KEY & Cert FUNCTIONS
# =============================================================================

# Generate SSH key pair
generate_ssh_key() {
    local key_path="$1"
    local comment="$2"
    local key_type="${3:-rsa}"
    local key_size="${4:-4096}"

    log_step "SSH" "Generating SSH key pair at: $key_path"

    # Ensure the directory exists
    local key_dir
    key_dir=$(dirname "$key_path")
    create_directory "$key_dir"

    # Generate key pair
    ssh-keygen -t "$key_type" -b "$key_size" -f "$key_path" -C "$comment" -N "" \
        || error_exit "Failed to generate SSH key pair at: $key_path"

    # Set proper permissions
    chmod 600 "$key_path" || warn "Failed to set permissions on private key: $key_path"
    chmod 644 "$key_path.pub" || warn "Failed to set permissions on public key: $key_path.pub"

    log_info "SSH key pair generated"
    log_info "Private key: $key_path"
    log_info "Public key: $key_path.pub"
}
