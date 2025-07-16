# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a proxy server that enables Claude Code to use Kimi K2 through Groq's API by translating between Anthropic's API format and OpenAI's format. The proxy intercepts Anthropic API calls and forwards them to Groq using the Kimi K2 model.

## Architecture

- **proxy.py**: Main FastAPI application that handles API translation
  - Converts Anthropic message format to OpenAI format for Groq
  - Handles tool calls and responses between the two API formats
  - Runs on port 7187 by default
  - Uses `moonshotai/kimi-k2-instruct` model via Groq
  - Caps max output tokens at 16384

## Common Commands

### Running the Proxy
```bash
python proxy.py
```

### Environment Setup
Set these environment variables before running Claude Code:
```bash
export ANTHROPIC_BASE_URL=http://localhost:7187
export ANTHROPIC_API_KEY=NOT_NEEDED
```

Ensure `GROQ_API_KEY` is set in your environment or .env file.

### Dependencies
The project uses Python with these key dependencies:
- FastAPI for the web server
- OpenAI client for Groq API communication
- Pydantic for data validation
- Uvicorn as ASGI server
- Rich for colored console output

Install dependencies with:
```bash
pip install -e .
```

Or with uv:
```bash
uv run proxy.py
```

## Key Implementation Details

### Message Conversion
- Text messages are passed through directly
- Tool use blocks are converted to OpenAI function call format
- Tool results are wrapped in `<tool_result>` XML tags
- All content is flattened to text format for Groq consumption

### Tool Handling
- Anthropic tool schemas are converted to OpenAI function schemas
- Tool calls from Groq are converted back to Anthropic tool_use blocks
- Tool results maintain their original structure but are JSON-serialized

### Response Format
The proxy returns responses in Anthropic's format with:
- Proper message IDs and model identification
- Token usage tracking from Groq
- Appropriate stop reasons (tool_use vs end_turn)