#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Migrate and do precomile
RAILS_ENV=production rails db:create
RAILS_ENV=production rails db:migrate
RAILS_ENV=production rails assets:precompile
RAILS_ENV=production rails action_text:install

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"