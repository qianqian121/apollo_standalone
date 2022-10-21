#!/usr/bin/env bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WORKHORSE="$1"

bash ${CURRENT_DIR}/install_ipopt.sh
bash ${CURRENT_DIR}/install_osqp.sh
bash ${CURRENT_DIR}/install_proj4.sh
bash ${CURRENT_DIR}/install_protobuf.sh
bash ${CURRENT_DIR}/install_qpOASES.sh
bash ${CURRENT_DIR}/install_fast-rtps.sh
sudo mkdir -p /usr/include/tinyxml2
sudo cp /usr/include/tinyxml2.h /usr/include/tinyxml2
bash ${CURRENT_DIR}/install_poco.sh
bash ${CURRENT_DIR}/install_qt.sh
