#!/bin/bash
set -e

rm -f /subscription_app_back/tmp/pids/server.pid

exec "$@"
