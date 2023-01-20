#!/bin/bash

if [ "true" ] ; then
  echo "worker env"
  bundle exec rake jobs:work
else
  echo "web env"
  exit 0
fi
