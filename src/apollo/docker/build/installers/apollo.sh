# This file was meant to be located at /etc/profile.d/apollo.sh

## Prevent multiple entries of my_bin_path in PATH
add_to_path() {
    if [ -z "$1" ]; then
        return
    fi
    my_bin_path="$1"
    if [ -n "${PATH##*${my_bin_path}}" ] && [ -n "${PATH##*${my_bin_path}:*}" ]; then
        export PATH=$PATH:${my_bin_path}
    fi
}

add_to_path /opt/apollo/sysroot/bin

export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=cpp

export QT5_PATH="/usr/local/qt5"
export QT_QPA_PLATFORM_PLUGIN_PATH="${QT5_PATH}/plugins"
add_to_path "${QT5_PATH}/bin"
export LD_LIBRARY_PATH=${QT5_PATH}/lib:$LD_LIBRARY_PATH
