#!/bin/bash

# run.sh - Setup environment, run proxy with logging, and start Claude Code

set -e

# Create logs directory if it doesn't exist
mkdir -p logs

# Install dependencies with uv
echo "Installing dependencies with uv..."
uv sync

# Set up environment variables
export ANTHROPIC_BASE_URL=http://localhost:7187
export ANTHROPIC_API_KEY=NOT_NEEDED

# Check if GROQ_API_KEY is set
if [ -z "$GROQ_API_KEY" ]; then
    echo "Warning: GROQ_API_KEY environment variable is not set"
    echo "Please set it before running this script or add it to .env file"
    exit 1
fi

# Start the proxy server in background with logging
echo "Starting proxy server..."
uv run python proxy.py > logs/proxy.log 2>&1 &
PROXY_PID=$!

# Wait a moment for the server to start
sleep 2

# Check if proxy is running
if ! kill -0 $PROXY_PID 2>/dev/null; then
    echo "Failed to start proxy server. Check logs/proxy.log for details."
    exit 1
fi

echo "Proxy server started (PID: $PROXY_PID) and logging to logs/proxy.log"
echo "Starting Claude Code..."

# Function to cleanup on exit
cleanup() {
    echo "Shutting down proxy server..."
    kill $PROXY_PID 2>/dev/null || true
    wait $PROXY_PID 2>/dev/null || true
    echo "Proxy server stopped"
}

# Set trap to cleanup on script exit
trap cleanup EXIT

# Run Claude Code
claude