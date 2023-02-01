#!/bin/bash

if [ "$WORKER_ENV" = "true" ] ; then
  echo "worker env"
  bundle exec sidekiq -e production -C config/sidekiq.yml
else
  echo "web env"
  while true
  do
    sleep 1
  done
fi
