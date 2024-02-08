#!/bin/bash

set -ex

mkdir -pv build
pushd build

# replace freedstock name in debug-prefix-map with source name
export CFLAGS=$(echo ${CFLAGS:-} | sed -E 's|'\/usr\/local\/src\/conda\/${PKG_NAME}'|/usr/local/src/conda/Fr|g')

# configure
cmake ${SRC_DIR} ${CMAKE_ARGS} \
	-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo \
	-DENABLE_C:BOOL=yes \
	-DENABLE_MATLAB:BOOL=no \
	-DENABLE_PACKAGING:BOOL=no \
	-DENABLE_PYTHON:BOOL=no \
;

# build
cmake --build . --parallel ${CPU_COUNT} --verbose

# install
cmake --build . --parallel ${CPU_COUNT} --verbose --target install
