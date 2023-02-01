#!/bin/bash
cd $STACK_PATH
bundle exec rake tenants:db:migrate
