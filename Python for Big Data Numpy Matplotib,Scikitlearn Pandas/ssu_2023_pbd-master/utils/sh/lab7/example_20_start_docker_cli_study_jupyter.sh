#!/usr/bin/env bash

set -u;
#set -x;

docker build -f Dockerfile.study_bd_jupyter -t study_bd_jupyter:latest .
docker run -d --rm --name study_bd_jupyter -p 8888:8888 -v $PWD:/app study_bd_jupyter:latest
google-chrome http://127.0.0.1:8888/lab/tree/samples/sample.ipynb

