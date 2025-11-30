#!/bin/bash
# system.sh - System and user management helper functions

# =============================================================================
# SYSTEM INFORMATION
# =============================================================================

# Set system hostname
set_hostname() {
    local new_hostname="$1"
    local fqdn="${2:-$new_hostname}"

    must_be_root

    log_step "SYSTEM" "Setting hostname to: $new_hostname"

    # Update hostname
    hostnamectl set-hostname "$new_hostname" || error_exit "Failed to set hostname: $new_hostname"

    # Update /etc/hosts
    backup_file "/etc/hosts" "/etc"

    # Remove old hostname entries
    sed -i '/127\.0\.1\.1/d' /etc/hosts

    # Add new hostname entry
    echo "127.0.1.1    $fqdn $new_hostname" >> /etc/hosts

    log_info "Hostname set to: $new_hostname"
}

# Set system FQDN
set_fqdn() {
    local fqdn="$1"
    local hostname="${2:-$(echo "$fqdn" | cut -d. -f1)}"

    set_hostname "$hostname" "$fqdn"
    log_info "FQDN set to: $fqdn"
}

# Add swap memory
add_swap_memory() {
    local swap_size="${1:-2G}"
    local swap_file="${2:-/swapfile}"

    must_be_root

    log_step "SYSTEM" "Adding swap memory: $swap_size"

    # Check if swap file already exists
    if [ -f "$swap_file" ]; then
        warn "Swap file already exists: $swap_file"
        return 1
    fi

    # Create swap file
    fallocate -l "$swap_size" "$swap_file" || error_exit "Failed to create swap file: $swap_file"
    chmod 600 "$swap_file"

    # Make it a swap file
    mkswap "$swap_file" || error_exit "Failed to make swap file: $swap_file"

    # Enable swap
    swapon "$swap_file" || error_exit "Failed to enable swap file: $swap_file"

    # Add to fstab for persistence
    backup_file "/etc/fstab" "/etc"
    echo "$swap_file none swap sw 0 0" >> /etc/fstab

    # Verify swap
    local total_swap
    total_swap=$(free -h | awk '/^Swap:/ { print $2 }')

    log_info "Swap memory added successfully: $swap_size"
    log_info "Total swap available: $total_swap"
}

# Remove swap memory
remove_swap_memory() {
    local swap_file="${1:-/swapfile}"

    must_be_root

    log_step "SYSTEM" "Removing swap memory: $swap_file"

    # Disable swap
    swapoff "$swap_file" 2>/dev/null || warn "Could not disable swap: $swap_file"

    # Remove from fstab
    backup_file "/etc/fstab" "/etc"
    sed -i "\|$swap_file|d" /etc/fstab

    # Remove swap file
    rm -f "$swap_file"

    log_info "Swap memory removed: $swap_file"
}

# Update system packages
update_system() {
    local upgrade="${1:-true}"

    must_be_root

    log_step "SYSTEM" "Updating system packages"

    local pm
    pm=$(detect_package_manager 2>/dev/null || echo "unknown")

    case "$pm" in
        apt)
            apt-get update || error_exit "Failed to update package lists"
            if [ "$upgrade" = "true" ]; then
                apt-get upgrade -y || warn "Some packages may not have been upgraded"
            fi
            ;;
        yum)
            yum check-update || true
            if [ "$upgrade" = "true" ]; then
                yum update -y || warn "Some packages may not have been updated"
            fi
            ;;
        dnf)
            dnf check-update || true
            if [ "$upgrade" = "true" ]; then
                dnf update -y || warn "Some packages may not have been updated"
            fi
            ;;
        pacman)
            pacman -Sy || error_exit "Failed to update package lists"
            if [ "$upgrade" = "true" ]; then
                pacman -Su --noconfirm || warn "Some packages may not have been upgraded"
            fi
            ;;
        zypper)
            zypper refresh || error_exit "Failed to update package lists"
            if [ "$upgrade" = "true" ]; then
                zypper update -y || warn "Some packages may not have been updated"
            fi
            ;;
        *)
            error_exit "Unsupported package manager for system update: $pm"
            ;;
    esac

    log_info "System update completed"
}

# Detect package manager
detect_package_manager() {
    if command -v apt-get >/dev/null 2>&1; then
        echo "apt"
    elif command -v dnf >/dev/null 2>&1; then
        echo "dnf"
    elif command -v yum >/dev/null 2>&1; then
        echo "yum"
    elif command -v pacman >/dev/null 2>&1; then
        echo "pacman"
    elif command -v zypper >/dev/null 2>&1; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

# Clean system packages
clean_system() {
    must_be_root

    log_step "SYSTEM" "Cleaning system packages"

    local pm
    pm=$(detect_package_manager 2>/dev/null || echo "unknown")

    case "$pm" in
        apt)
            apt-get autoremove -y || warn "Could not remove unnecessary packages"
            apt-get autoclean || warn "Could not clean package cache"
            ;;
        yum)
            yum autoremove -y || warn "Could not remove unnecessary packages"
            yum clean all || warn "Could not clean package cache"
            ;;
        dnf)
            dnf autoremove -y || warn "Could not remove unnecessary packages"
            dnf clean all || warn "Could not clean package cache"
            ;;
        pacman)
            pacman -Rns $(pacman -Qtdq) 2>/dev/null || true
            pacman -Scc --noconfirm || warn "Could not clean package cache"
            ;;
        zypper)
            zypper remove -u $(zypper packages --unneeded | awk '/^i+/ {print $5}' | tail -n +5) 2>/dev/null || true
            zypper clean || warn "Could not clean package cache"
            ;;
        *)
            warn "System cleaning not supported for package manager: $pm"
            ;;
    esac

    log_info "System cleaning completed"
}
