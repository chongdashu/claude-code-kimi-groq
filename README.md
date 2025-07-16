# Use Kimi K2 on Claude Code through Groq

This project builds upon the original repository at https://github.com/fakerybakery/claude-code-kimi-k2 (formerly `claude-code-kimi-groq`), enhancing it with additional features and improvements.

A proxy server that enables Claude Code to use Kimi K2 (Moonshot AI's model) through Groq's API by converting between Anthropic and OpenAI API formats.

## Quick Start

### Installation

```bash
# Install dependencies
pip install -e .

# Or with uv
uv run proxy.py
```

### Running the Proxy

```bash
# Using uv (recommended)
uv run proxy.py

# Using python
python proxy.py

# Or using the CLI (after installation)
proxy
```

### Configuration

Set environment variables before running Claude Code:

```bash
export ANTHROPIC_BASE_URL=http://localhost:7187
export ANTHROPIC_API_KEY=NOT_NEEDED
# Ensure GROQ_API_KEY is set in your environment or .env file
```

Then run Claude Code:

```bash
claude
```

### Alternate Run Methods

```bash
# Using the shell scripts
./run.sh
# or
./run-claude.sh  # sets environment variables automatically
```

## Architecture

The proxy handles:
- **Message Format Conversion**: Translates between Anthropic and OpenAI message formats
- **Tool Handling**: Converts tool schemas and function calls between API formats
- **Response Mapping**: Returns responses in Anthropic's expected format with proper message IDs and token usage

The server runs on port 7187 by default and uses the Kimi K2 model through Groq's API.

## If you use this:

If you use this, I'd love to hear about your experience with Kimi K2 and how it compared with Claude! Please open an Issue to share your experience.

## Acknowledgements

Inspired by [claude-code-proxy](https://github.com/1rgs/claude-code-proxy)

## License

MIT