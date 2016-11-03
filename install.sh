#!/bin/sh

echo source http://www.spontaneoussymmetry.com/blog/2012-12-18-blaze
    apk update &&
    apk upgrade &&
    echo Move to a clean directory &&
    mkdir /usr/local/src &&
    cd /usr/local/src &&
    echo Create a local virtual environment and then activate it. &&
    apk add python &&
    apk add py-pip &&
    pip install --upgrade pip &&
    pip install virtualenv &&
    virtualenv venv --distribute &&
    . venv/bin/activate &&
    echo Checkout the 'conda' build system &&
    apk add git &&
    git clone https://github.com/conda/conda.git &&
    cd conda &&
    python setup.py build &&
    python setup.py install &&
    cd .. &&
    mkdir venv/pkgs &&
    cd conda &&
    ./conda install ply &&
    ./conda install blosc &&
    ./conda install aterm &&
    pip install Cython &&
    pip install numpy &&
    pip install numexpr &&
    export DYLD_LIBRARY_PATH=PWD/venv/lib:PWD/venv/lib:{DYLD_LIBRARY_PATH} &&
    export LD_LIBRARY_PATH=PWD/venv/lib:PWD/venv/lib:{LD_LIBRARY_PATH} &&
    git clone git@github.com:ContinuumIO/blaze.git &&
    cd /usr/local/src &&
    make build &&
    make docs &&
    python setup.py install &&
    export PYTHONPATH=${PWD}/blaze:PWD/blaze:PYTHONPATH &&
    true