#!/usr/bin/env bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WORKHORSE="$1"

bash ${CURRENT_DIR}/install_opencv.sh "${WORKHORSE}" "yes"


sudo ldconfig
