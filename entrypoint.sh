#!/bin/sh
set -e

# Function to handle shutdown
shutdown() {
  echo "Shutting down..."
  kill -TERM "$hbbs_pid" 2>/dev/null || true
  kill -TERM "$hbbr_pid" 2>/dev/null || true
  wait
  exit 0
}

# Trap SIGTERM and SIGINT
trap 'shutdown' SIGTERM SIGINT

# Start hbbs and hbbr in the background
echo "Starting hbbs and hbbr..."
hbbs -r 0.0.0.0:21117 &
hbbs_pid=$!

hbbr &
hbbr_pid=$!

# Wait for both processes to finish
wait "$hbbs_pid" "$hbbr_pid"
