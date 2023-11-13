#!/bin/bash

set -ex

_builddir="_build${PY_VER}"
mkdir -pv ${_builddir}
pushd ${_builddir}

# replace freedstock name in debug-prefix-map with source name
export CFLAGS=$(echo ${CFLAGS:-} | sed -E 's|'\/usr\/local\/src\/conda\/${PKG_NAME}'|/usr/local/src/conda/Fr|g')

# configure
cmake ${SRC_DIR} ${CMAKE_ARGS} \
	-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo \
	-DENABLE_C:BOOL=no \
	-DENABLE_MATLAB:BOOL=no \
	-DENABLE_PYTHON:BOOL=yes \
	-DPython3_EXECUTABLE:FILEPATH="${PYTHON}" \
;

# build
cmake --build ./Python --parallel ${CPU_COUNT} --verbose

# install
cmake --build ./Python --parallel ${CPU_COUNT} --verbose --target install
