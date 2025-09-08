#!/bin/bash
PROXY="http://rnds:Rndssdnr1@10.6.0.150:4444"

docker compose build \
#  --build-arg HTTP_PROXY=$PROXY \
#  --build-arg HTTPS_PROXY=$PROXY \
#  --build-arg http_proxy=$PROXY \
#  --build-arg https_proxy=$PROXY.

docker compose up -d