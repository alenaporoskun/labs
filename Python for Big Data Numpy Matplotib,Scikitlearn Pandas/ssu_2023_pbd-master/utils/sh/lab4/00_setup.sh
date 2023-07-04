#!/usr/bin/env bash

set -u;
#set -x;

DN=dataset/arc/master/data

mkdir -p "$DN"

cat <<- 'EOF' > "$DN/test.csv"
year,price
2001,100
2002,150
2003,200
EOF

cd dataset

zip -9mr test.zip arc/
