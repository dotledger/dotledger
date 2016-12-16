#!/bin/sh -e

PORT=${PORT:-3000}
BINDING=${BINDING:-0.0.0.0}

if [ "$#" -eq "0" ] ; then
  bundle exec rake assets:precompile
  bundle exec rake db:migrate
  bundle exec rails server --port=$PORT --binding=$BINDING
else
  exec "$@"
fi