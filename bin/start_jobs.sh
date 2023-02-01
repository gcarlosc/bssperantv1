#!/bin/bash

if [ "$WORKER_ENV" = "true" ] ; then
  echo "worker env"
  bundle exec rake jobs:work
else
  echo "web env"
  while true
  do
      sleep 1
  done
fi
