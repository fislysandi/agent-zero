#!/bin/bash
set -e

# install playwright - moved to install A0
# bash /ins/install_playwright.sh "$@"

# searxng - moved to base image
# bash /ins/install_searxng.sh "$@"

echo "Installing Codex CLI..."

for attempt in 1 2 3; do
    if npm install -g @openai/codex; then
        break
    fi

    if [ "$attempt" -eq 3 ]; then
        echo "ERROR: failed to install @openai/codex after ${attempt} attempts" >&2
        exit 1
    fi

    sleep_seconds=$((attempt * 5))
    echo "Codex CLI install failed (attempt ${attempt}); retrying in ${sleep_seconds}s..." >&2
    sleep "$sleep_seconds"
done

codex --version
