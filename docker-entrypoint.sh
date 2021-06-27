#!/bin/sh

mix deps.get
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to get deps: $status"
  exit $status
fi

mix deps.compile
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to compile deps: $status"
  exit $status
fi

mix phx.server
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start phx: $status"
  exit $status
fi
