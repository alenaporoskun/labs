#!/usr/bin/env bash

set -u;
#set -x;
#set -e

virtualenv venv -p python3
source venv/bin/activate

which python

pip install --upgrade pip
pip install -r requirements.txt
