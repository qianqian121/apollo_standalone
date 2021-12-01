#! /usr/bin/env bash
APOLLO_ROOT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd -P)"
source /etc/profile.d/apollo.sh

export CYBER_PATH="${APOLLO_ROOT_DIR}/cyber"

binary_path="${APOLLO_ROOT_DIR}/bin"
lib_path="${APOLLO_ROOT_DIR}/lib"
proto_path="/usr/local/lib"

export LD_LIBRARY_PATH=${proto_path}:${lib_path}:$LD_LIBRARY_PATH
export PATH=${binary_path}:$PATH

export CYBER_DOMAIN_ID=80
#export CYBER_IP=127.0.0.1
export CYBER_IP=192.168.1.240

APOLLO_LOG_DIR="${APOLLO_ROOT_DIR}/data/log"
if [[ ! -d $APOLLO_LOG_DIR ]]; then
    mkdir -p $APOLLO_LOG_DIR
fi
export GLOG_log_dir="${APOLLO_LOG_DIR}"
#export GLOG_alsologtostderr=0
export GLOG_alsologtostderr=1
export GLOG_colorlogtostderr=1
export GLOG_minloglevel=0

export sysmo_start=0

# for DEBUG log
#export GLOG_minloglevel=-1
#export GLOG_v=4

source ${CYBER_PATH}/tools/cyber_tools_auto_complete.bash
