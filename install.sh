#!/bin/sh

apk update &&
    apk upgrade &&
    apk add python &&
    apk add py-pip &&
    pip install virtualenv &&
    cd /usr/local/src &&
    virtualenv venv --distribute &&
    . venv/bin/activate &&
    git clone git@github.com:ContinuumIO/conda.git &&
    cd conda &&
    python setup.sh build &&
    python setup.sh install &&
    cd .. &&
    mkdir venv/pkgs &&
    cd conda &&
    ./bin/conda install ply &&
    ./bin/conda install blosc &&
    ./bin/conda install aterm &&
    pip install Cython &&
    pip install numpy &&
    pip install numexpr &&
    export DYLD_LIBRARY_PATH=PWD/venv/lib:PWD/venv/lib:{DYLD_LIBRARY_PATH} &&
    export LD_LIBRARY_PATH=PWD/venv/lib:PWD/venv/lib:{LD_LIBRARY_PATH} &&
    git clone git@github.com:ContinuumIO/blaze.git &&
    cd blaze &&
    make build &&
    make docs &&
    python setup.py install &&
    export PYTHONPATH=${PWD}/blaze:PWD/blaze:PYTHONPATH &&
    true