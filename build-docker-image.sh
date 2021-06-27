#!/bin/sh

docker build -t docker.io/valrai/getwork:latest --file Dockerfile .
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to build: $status"
  exit $status
fi
