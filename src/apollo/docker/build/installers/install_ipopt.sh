#!/bin/bash
set -e # exit on first error
SOURCE_DIR="/tmp"

install_ipopt()
{
    sudo add-apt-repository universe &&  sudo apt-get -y update
    sudo apt-get install -y libblas-dev liblapack-dev gfortran libmetis-dev
    cd ${SOURCE_DIR}
    git clone https://github.com/coin-or-tools/ThirdParty-Mumps.git
    cd ThirdParty-Mumps
    ./get.Mumps
    ./configure
    make
    sudo make install
    cd ${SOURCE_DIR}
    wget https://www.coin-or.org/download/source/Ipopt/Ipopt-3.13.2.zip -O Ipopt-3.13.2.zip
    unzip Ipopt-3.13.2.zip
#    cd Ipopt-3.13.2/ThirdParty/Mumps
#    bash get.Mumps
    cd ${SOURCE_DIR}/Ipopt-releases-3.13.2
    ./configure --prefix /usr/local --disable-shared ADD_CXXFLAGS="-fPIC" ADD_CFLAGS="-fPIC" ADD_FFLAGS="-fPIC"
    make -j all
    sudo make install
}

install_ipopt
