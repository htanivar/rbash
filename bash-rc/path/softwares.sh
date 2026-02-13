#!/bin/bash

# softwares.sh - Dynamic PATH setter with software availability check
# Usage: source softwares.sh in your .bashrc


# Base directory for software installations
OPT_DIR="/apps"
GO_VERSION="go1.24.12"
JDK_VERSION="17.0.17"

# Directory for soft links
SLINK_BIN_DIR="$HOME/bin"

# Software list with their expected subdirectories and executables
declare -A SOFTWARE=(
    ["gimp"]="gimp:GIMP-3.0.0-RC3-x86_64.AppImage"
    ["intellij"]="intellij/bin:idea.sh"
    ["studio"]="android-studio/bin:studio.sh"
    ["webstorm"]="webstorm/bin:webstorm.sh"
    ["pycharm"]="pycharm/bin:pycharm.sh"
    ["goland"]="goland/bin:goland.sh"
    ["go"]="go/go1.24.12/bin:go"
    ["flutter"]="flutter/bin:flutter"
    ["java"]="java/jdk-${JDK_VERSION}/bin:java"
    ["gradle"]="gradle/gradle-9.2.0/bin:gradle"
    ["maven"]="maven/bin:mvn"
)




# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to create soft link and wrapper script
create_soft_link() {
    local software=$1
    local exec_path=$2
    local link_name="$SLINK_BIN_DIR/$software"

    # Create wrapper script for detached mode
    local wrapper_script="/tmp/${software}_wrapper.sh"
    cat > "$wrapper_script" << EOF
#!/bin/bash
export DISPLAY=:0
nohup "$exec_path" "\$@" > /tmp/${software}_nohup.out 2>&1 &
disown
EOF

    chmod +x "$wrapper_script"

    # 2. Create soft link to wrapper (No sudo required)
    ln -sf "$wrapper_script" "$link_name" 2>/dev/null

    # 3. Check and report
    if [ $? -eq 0 ]; then
        log_debug "${GREEN}  → Soft link created: $link_name${NC}"
    else
        # This failure is unlikely with $HOME/bin, but handles general errors
        echo -e "${RED}  → ERROR: Failed to create soft link for $software.${NC}"
    fi
}


# Function to check and add to PATH
check_and_add_path() {
    local software=$1
    local path_info=${SOFTWARE[$software]}
    local subdir=$(echo $path_info | cut -d':' -f1)
    local executable=$(echo $path_info | cut -d':' -f2)

    local full_path="$OPT_DIR/$subdir"
    local exec_path="$full_path/$executable"

    if [ -d "$full_path" ] && [ -f "$exec_path" ]; then
        # *** FIX for duplicate PATH entries ***
        # Check if the full_path is ALREADY in the PATH variable
        if ! echo "$PATH" | grep -q "$full_path"; then
            export PATH="$full_path:$PATH"
            echo -e "${GREEN}✓${NC} $software found and added to PATH"
        else
            echo -e "${GREEN}✓${NC} $software found. Already in PATH."
        fi
        # ***********************************

        # Create soft link for detached execution (except for go)
        if [ "$software" != "go" ]; then
            create_soft_link "$software" "$exec_path"
        fi

        # Set specific environment variables (no change needed here)
        case $software in
        # ... (rest of the case statement remains the same)
        "intellij")
            export IDEA_HOME="$OPT_DIR/intellij"
            ;;
        # ...
        "go")
           export GOROOT="$OPT_DIR/go/$GO_VERSION"
               export GOPATH="$HOME/go"

               if ! echo "$PATH" | grep -q "$GOROOT/bin"; then
                   export PATH="$GOROOT/bin:$PATH"
               fi
           
               if ! echo "$PATH" | grep -q "$GOPATH/bin"; then
                   export PATH="$GOPATH/bin:$PATH"
               fi
               ;;
        esac
    else
        echo -e "${RED}✗${NC} $software not found at $full_path"
        echo -e "${YELLOW}  →${NC} Expected executable: $exec_path"
        echo -e "${YELLOW}  →${NC} Please download and install $software to $full_path"
    fi
}

# Main execution
echo -e "${YELLOW}Checking software availability in $OPT_DIR...${NC}"

# Check each software
for software in "${(@k)SOFTWARE}"; do
    check_and_add_path "$software"
done


export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


echo -e "${GREEN}PATH setup complete!${NC}"



