#!/bin/bash

if [ "$WORKER_ENV" = "true" ] ; then
  echo "worker env"
  bundle exec sidekiq -e production -C config/sidekiq.yml
else
  echo "web env"
  exit 0
fi