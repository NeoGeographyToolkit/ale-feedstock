#!/bin/bash

set -e # Abort on error

mkdir build && cd build
cmake ${CMAKE_ARGS} -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_INSTALL_LIBDIR=lib -DALE_BUILD_TESTS=OFF -DALE_BUILD_DOCS=OFF ..
cmake --build . --target install
cd ..
$PYTHON -m pip install . --no-deps --no-build-isolation -vv
