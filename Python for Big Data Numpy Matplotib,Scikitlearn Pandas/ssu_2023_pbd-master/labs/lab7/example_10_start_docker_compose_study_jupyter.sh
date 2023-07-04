#!/usr/bin/env bash

set -u;
#set -x;

docker-compose down
docker-compose build study_bd_jupyter
docker-compose up -d study_bd_jupyter
google-chrome http://127.0.0.1:8888/lab/tree/samples/sample.ipynb
