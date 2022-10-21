#!/usr/bin/env bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WORKHORSE="$1"

bash ${CURRENT_DIR}/install_minimal_environment.sh us
sudo apt update
sudo apt -y upgrade
bash ${CURRENT_DIR}/install_curlpp.sh
bash ${CURRENT_DIR}/install_adolc.sh
bash ${CURRENT_DIR}/install_glogs_gflags.sh
