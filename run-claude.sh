#!/bin/bash

# Script to run Claude Code with the local proxy
# Make sure the proxy is running first with: uv run python proxy.py

export ANTHROPIC_BASE_URL=http://localhost:7187
export ANTHROPIC_API_KEY=NOT_NEEDED

echo "🚀 Starting Claude Code with Kimi K2 proxy..."
echo "   Base URL: $ANTHROPIC_BASE_URL"
echo "   Make sure proxy is running on localhost:7187"
echo ""

# Run Claude Code with the proxy settings
claude "$@"