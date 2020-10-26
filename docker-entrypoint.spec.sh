#!/bin/sh -e

if [ "$#" -eq "0" ] ; then
  bundle exec rake db:create
  bundle exec rake db:test:prepare
  bundle exec rspec
else
  exec "$@"
fi
