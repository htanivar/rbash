#!/bin/bash

OPT_DIR="/apps"
GO_VERSION="go1.26.1"
JDK_VERSION="17.0.17"

SLINK_BIN_DIR="$HOME/bin"

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

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Only GUI apps should use wrapper
is_gui_app() {
    case "$1" in
        gimp|intellij|studio|webstorm|pycharm|goland) return 0 ;;
        *) return 1 ;;
    esac
}

create_soft_link() {
    local software=$1
    local exec_path=$2
    local link_name="$SLINK_BIN_DIR/$software"

    local wrapper_script="/tmp/${software}_wrapper.sh"
    cat > "$wrapper_script" << EOF
#!/bin/bash
export DISPLAY=:0
nohup "$exec_path" "\$@" > /tmp/${software}_nohup.out 2>&1 &
disown
EOF

    chmod +x "$wrapper_script"
    ln -sf "$wrapper_script" "$link_name"
}

add_to_path() {
    local path=$1
    if [[ ":$PATH:" != *":$path:"* ]]; then
        export PATH="$path:$PATH"
    fi
}

check_and_add_path() {
    local software=$1
    local path_info=${SOFTWARE[$software]}
    local subdir=$(echo $path_info | cut -d':' -f1)
    local executable=$(echo $path_info | cut -d':' -f2)

    local full_path="$OPT_DIR/$subdir"
    local exec_path="$full_path/$executable"

    if [ -d "$full_path" ] && [ -f "$exec_path" ]; then
        add_to_path "$full_path"
        echo -e "${GREEN}✓${NC} $software ready"

        # GUI apps → wrapper
        if is_gui_app "$software"; then
            create_soft_link "$software" "$exec_path"
        fi

        case $software in
            "java")
                export JAVA_HOME="$OPT_DIR/java/jdk-${JDK_VERSION}"
                add_to_path "$JAVA_HOME/bin"
                ;;
            "go")
                export GOROOT="$OPT_DIR/go/$GO_VERSION"
                export GOPATH="$HOME/go"
                add_to_path "$GOROOT/bin"
                add_to_path "$GOPATH/bin"
                ;;
        esac
    else
        echo -e "${RED}✗${NC} $software missing at $full_path"
    fi
}

echo -e "${YELLOW}Checking software in $OPT_DIR...${NC}"

for software in "${(@k)SOFTWARE}"; do
    check_and_add_path "$software"
done

# Android setup
export ANDROID_HOME="/apps/Android/Sdk"
export ANDROID_SDK_ROOT="/apps/Android/Sdk"

add_to_path "$ANDROID_HOME/emulator"
add_to_path "$ANDROID_HOME/platform-tools"
add_to_path "$ANDROID_HOME/cmdline-tools/latest/bin"

echo -e "${GREEN}Environment ready!${NC}"