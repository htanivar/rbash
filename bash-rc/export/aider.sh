#!/bin/bash

# Slim + code-focused DeepSeek setup for Aider

export OPENAI_API_BASE="https://api.deepseek.com"
export OPENAI_API_KEY="YOUR_DEEPSEEK_API_KEY"

# Lowest chatter, best for pure coding
export OPENAI_MODEL="deepseek-coder"

# Hard limit verbosity
export AIDER_SYSTEM_PROMPT="You are a coding agent. Output code or git diffs only. No explanations."

# Optional but recommended
export AIDER_SHOW_DIFFS=true
export AIDER_NO_MARKDOWN=true
