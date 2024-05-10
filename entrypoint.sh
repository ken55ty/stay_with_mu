#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /stay_with_mu/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
bundle install
yarn install
yarn build
bundle exec rake assets:precompile
bundle exec rails db:migrate
bundle exec rails db:seed
bundle exec sidekiq
exec "$@"