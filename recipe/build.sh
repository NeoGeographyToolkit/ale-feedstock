#!/bin/bash

set -e # Abort on error

mkdir build && cd build
cmake ${CMAKE_ARGS} -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_INSTALL_LIBDIR=lib -DALE_BUILD_TESTS=OFF -DALE_BUILD_DOCS=OFF ..
cmake --build . --target install
cd ..
$PYTHON -m pip install . --no-deps --no-build-isolation -vv

# The SWIG wrapper ale/ale_c.py is generated during build_ext (swig -python),
# AFTER setuptools' build_py has already snapshotted the python sources, so
# `pip install` ships ale/_ale_c.so but silently omits ale/ale_c.py. The umbrella
# data_naif.py imports `ale_c` eagerly (unguarded), so `import ale` fails without
# the wrapper. Install the freshly generated wrapper next to its compiled module.
cp ale/ale_c.py ${SP_DIR}/ale/ale_c.py
