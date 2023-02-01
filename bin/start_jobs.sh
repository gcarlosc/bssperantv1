#!/bin/bash

if [ "$WORKER_ENV" = "true" ] ; then
  echo "worker env"
  bundle exec rake jobs:work
else
  echo "web env"
  exit 1
fi
