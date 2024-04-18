#!/bin/sh

# Abort on any error (including if wait-for-it fails).
set -e

# Wait for the frontend to be up, if we know where it is.
if [ -n "$HANGMAN_FRONT_HOST" ]; then
  /app/wait-for-it.sh "$HANGMAN_FRONT_HOST:${HANGMAN_FRONT_PORT:-8080}"
fi

# Run the main container command.
exec "$@"