#!/bin/bash
# --- Aider setting ---
alias aider-deepseek='aider --model openai/deepseek-chat --openai-api-base https://api.deepseek.com --openai-api-key $DEEPSEEK_API_KEY'

# Aider config base
export AIDER_CNF="$HOME/.aider"

# Aider aliases (Aider 0.86.1 compatible, DeepSeek)

alias aider-bash="aider -c $AIDER_CNF/bash.yml --deepseek --no-pretty --show-diffs"
alias aider-code="aider -c $AIDER_CNF/coding.yml --deepseek --no-pretty --show-diffs"
alias aider-docs="aider -c $AIDER_CNF/tech_docs.yml --deepseek"
alias aider-arch="aider -c $AIDER_CNF/architecture.yml --deepseek"
alias aider-user="aider -c $AIDER_CNF/user_docs.yml --deepseek"
alias aider-legal="aider -c $AIDER_CNF/legal.yml --deepseek"
alias aider-devops="aider -c $AIDER_CNF/devops.yml --deepseek --no-pretty --show-diffs"
alias aider-refactor="aider -c $AIDER_CNF/refactor.yml --deepseek --show-diffs"
alias aider-silent="aider -c $AIDER_CNF/silent.yml --deepseek --no-pretty"
alias aider-reason="aider -c $AIDER_CNF/reasoning.yml --deepseek --no-pretty"

alias aider-clean='find . -maxdepth 1 -type f -name "--system_prompt*" -exec rm -f -- {} +'

