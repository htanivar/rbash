#!/bin/bash
# --- Aider setting ---
export AIDER_CNF="$HOME/.aider"

# Deepseek base alias (keep as alias since it's simple)
alias aider-deepseek='aider --model openai/deepseek-chat --openai-api-base https://api.deepseek.com --openai-api-key $DEEPSEEK_API_KEY'

# First, unalias all existing aider aliases to avoid conflicts
for cmd in bash code docs arch user legal devops refactor silent reason flutter react test auto debug clean; do
    unalias "aider-$cmd" 2>/dev/null
done

# Bash function
aider-bash() {
    export AIDER_SYSTEM_PROMPT="You are a bash scripting expert. Output only valid bash scripts or unified diffs. Use POSIX-compliant shell where possible. No explanations. Include error handling."
    export AIDER_MODEL="deepseek/deepseek-coder"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    export AIDER_SUGGEST_SHELL_COMMANDS="false"
    export AIDER_NO_PRETTY="true"
    command aider --show-diffs "$@"
}

# Code/Fullstack function
aider-code() {
    export AIDER_SYSTEM_PROMPT="You are an expert Senior Full Stack Engineer. No preamble or explanations. Use concise, direct tone. Minimize output tokens while maintaining 100% accuracy. No comments. Output only valid code or diffs."
    export AIDER_MODEL="deepseek/deepseek-coder"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    export AIDER_SUGGEST_SHELL_COMMANDS="false"
    export AIDER_NO_PRETTY="true"
    command aider --show-diffs "$@"
}

# Docs function
aider-docs() {
    export AIDER_SYSTEM_PROMPT="You are a technical documentation expert. Create clear, comprehensive documentation with examples. Use markdown format. Be concise but thorough."
    export AIDER_MODEL="deepseek/deepseek-chat"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    command aider "$@"
}

# Architecture function
aider-arch() {
    export AIDER_SYSTEM_PROMPT="You are a software architecture expert. Focus on system design, scalability, patterns, and best practices. Provide architecture diagrams in text/ASCII when helpful. Consider trade-offs."
    export AIDER_MODEL="deepseek/deepseek-chat"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    command aider "$@"
}

# User docs function
aider-user() {
    export AIDER_SYSTEM_PROMPT="You are a user documentation expert. Create user-friendly documentation with clear instructions. Use simple language. Include step-by-step guides and examples."
    export AIDER_MODEL="deepseek/deepseek-chat"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    command aider "$@"
}

# Legal function
aider-legal() {
    export AIDER_SYSTEM_PROMPT="You draft formal legal and compliance documents. Use neutral, precise, unambiguous language. Avoid assumptions. Follow legal document structure. Include standard clauses where appropriate."
    export AIDER_MODEL="deepseek/deepseek-chat"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    command aider "$@"
}

# DevOps function
aider-devops() {
    export AIDER_SYSTEM_PROMPT="You are a DevOps expert. Focus on infrastructure as code, CI/CD pipelines, containerization, orchestration, and cloud technologies. Provide practical, secure solutions."
    export AIDER_MODEL="deepseek/deepseek-coder"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    export AIDER_SUGGEST_SHELL_COMMANDS="false"
    export AIDER_NO_PRETTY="true"
    command aider --show-diffs "$@"
}

# Refactor function
aider-refactor() {
    export AIDER_SYSTEM_PROMPT="You are a code refactoring expert. Focus on improving code quality, performance, readability, and maintainability. Suggest minimal changes for maximum impact. Preserve functionality."
    export AIDER_MODEL="deepseek/deepseek-coder"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    export AIDER_SUGGEST_SHELL_COMMANDS="false"
    command aider --show-diffs "$@"
}

# Silent function (minimal output)
aider-silent() {
    export AIDER_SYSTEM_PROMPT="You are a coding expert. Provide minimal, concise responses with code only. No explanations. No comments. Maximum token efficiency."
    export AIDER_MODEL="deepseek/deepseek-coder"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    export AIDER_SUGGEST_SHELL_COMMANDS="false"
    export AIDER_NO_PRETTY="true"
    command aider "$@"
}

# Reasoning function
aider-reason() {
    export AIDER_SYSTEM_PROMPT="You are a reasoning expert. Provide step-by-step logical reasoning for complex problems. Show your work. Then provide the solution."
    export AIDER_MODEL="deepseek/deepseek-chat"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    export AIDER_NO_PRETTY="true"
    command aider "$@"
}

# Flutter function
aider-flutter() {
    export AIDER_SYSTEM_PROMPT="You are a Flutter expert. Follow these rules:
- Output ONLY valid Dart code or unified diffs
- NO explanations, NO comments, NO markdown
- Use exact Flutter API names from official docs
- Include ALL required imports
- Use sound null safety (!, ?, late, required)
- Material 3 by default
- Responsive: use LayoutBuilder, MediaQuery, Expanded
- State management: Provider/Riverpod/Bloc when appropriate
- For diffs: show only changed lines with context"
    export AIDER_MODEL="deepseek/deepseek-coder"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    export AIDER_SUGGEST_SHELL_COMMANDS="false"
    export AIDER_NO_PRETTY="true"
    command aider "$@"
}

# React function
aider-react() {
    export AIDER_SYSTEM_PROMPT="You are a React/TypeScript expert. Follow these rules:
- Output ONLY valid TSX/TS code or unified diffs
- NO explanations, NO comments
- Use functional components with hooks
- Include proper TypeScript typing
- Follow modern React best practices
- Use Tailwind CSS when appropriate
- Handle edge cases and errors"
    export AIDER_MODEL="deepseek/deepseek-coder"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    export AIDER_SUGGEST_SHELL_COMMANDS="false"
    export AIDER_NO_PRETTY="true"
    command aider "$@"
}

# Test function (for writing tests)
aider-test() {
    export AIDER_SYSTEM_PROMPT="You are a testing expert. Follow these rules:
- Write comprehensive tests (unit, integration, e2e as appropriate)
- Use the testing framework appropriate for the project
- Include edge cases and error scenarios
- Follow AAA pattern (Arrange, Act, Assert)
- Mock external dependencies
- Achieve high coverage without being redundant
- NO explanations, just test code"
    export AIDER_MODEL="deepseek/deepseek-coder"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    export AIDER_SUGGEST_SHELL_COMMANDS="false"
    export AIDER_NO_PRETTY="true"
    command aider "$@"
}

# Auto function (for automation/scripts)
aider-auto() {
    export AIDER_SYSTEM_PROMPT="You are an automation expert. Follow these rules:
- Create robust automation scripts
- Include error handling and logging
- Make scripts idempotent when possible
- Add input validation
- Include comments for complex logic
- Follow best practices for the target language/shell
- Consider cross-platform compatibility
- Output ONLY runnable code"
    export AIDER_MODEL="deepseek/deepseek-coder"
    export AIDER_EDIT_FORMAT="diff"
    export AIDER_ATTRIBUTE_AUTHOR="true"
    export AIDER_SUGGEST_SHELL_COMMANDS="false"
    export AIDER_NO_PRETTY="true"
    command aider --show-diffs "$@"
}

# Debug function - shows what environment variables are being set
aider-debug() {
    echo "🔍 AIDER DEBUG MODE"
    echo "==================="
    echo ""

    # Show current AIDER environment variables
    echo "Current AIDER environment variables:"
    env | grep AIDER_ | sort || echo "  None set"
    echo ""

    # Show what would be set for each personality
    echo "Available personalities and their prompts:"
    echo "----------------------------------------"

    for personality in bash code docs arch user legal devops refactor silent reason flutter react test auto; do
        echo ""
        echo "📌 aider-$personality:"
        # Temporarily set variables for this personality to show preview
        case "$personality" in
            bash)      local prompt="You are a bash scripting expert..." ;;
            code)      local prompt="You are an expert Senior Full Stack Engineer..." ;;
            docs)      local prompt="You are a technical documentation expert..." ;;
            arch)      local prompt="You are a software architecture expert..." ;;
            user)      local prompt="You are a user documentation expert..." ;;
            legal)     local prompt="You draft formal legal and compliance documents..." ;;
            devops)    local prompt="You are a DevOps expert..." ;;
            refactor)  local prompt="You are a code refactoring expert..." ;;
            silent)    local prompt="You are a coding expert. Minimal output..." ;;
            reason)    local prompt="You are a reasoning expert..." ;;
            flutter)   local prompt="You are a Flutter expert. Code only. No words." ;;
            react)     local prompt="You are a React/TypeScript expert..." ;;
            test)      local prompt="You are a testing expert..." ;;
            auto)      local prompt="You are an automation expert..." ;;
        esac
        echo "  PROMPT: ${prompt:0:80}..."  # Show first 80 chars
        echo "  MODEL: deepseek/deepseek-$( [[ "$personality" =~ ^(docs|arch|user|legal|reason)$ ]] && echo "chat" || echo "coder")"
        echo "  FORMAT: diff"
    done
    echo ""
    echo "To run with debug logging:"
    echo "  aider-debug-run <personality> [args]"
    echo ""
    echo "Example: aider-debug-run flutter 'Create a button'"
}

# Debug run function - runs a personality with verbose output
aider-debug-run() {
    local personality="$1"
    shift

    echo "🚀 DEBUG RUN: aider-$personality"
    echo "================================"
    echo "Arguments: $@"
    echo ""

    # Show environment before
    echo "📤 Environment BEFORE:"
    env | grep AIDER_ | sort | sed 's/^/  /'
    echo ""

    # Run the actual command with time and verbose output
    echo "⚡ Executing: aider-$personality $@"
    echo "----------------------------------------"

    # Use time and verbose flag
    TIME_START=$(date +%s%N)
    COMMAND="aider-$personality"  # This will call the function
    "$COMMAND" "$@" --verbose 2>&1 | tee /tmp/aider-debug.log
    EXIT_CODE=$?
    TIME_END=$(date +%s%N)
    TIME_MS=$(( ($TIME_END - $TIME_START) / 1000000 ))

    echo "----------------------------------------"
    echo "✅ Exit code: $EXIT_CODE"
    echo "⏱️  Time: ${TIME_MS}ms"
    echo "📝 Debug log: /tmp/aider-debug.log"

    # Show environment after
    echo ""
    echo "📥 Environment AFTER:"
    env | grep AIDER_ | sort | sed 's/^/  /'

    return $EXIT_CODE
}

# Debug check function - validates if a personality function exists
aider-debug-check() {
    local personality="$1"

    if [[ -z "$personality" ]]; then
        echo "❌ Usage: aider-debug-check <personality>"
        echo "   Example: aider-debug-check flutter"
        return 1
    fi

    echo "🔍 Checking aider-$personality..."
    echo ""

    # Check if function exists
    if type "aider-$personality" 2>/dev/null | grep -q "function"; then
        echo "✅ Function aider-$personality exists"
    else
        echo "❌ Function aider-$personality NOT found"
    fi

    # Check if alias exists
    if alias "aider-$personality" 2>/dev/null; then
        echo "⚠️  Alias aider-$personality exists (might conflict)"
    fi

    # Show function definition
    echo ""
    echo "📋 Function definition:"
    type "aider-$personality" 2>/dev/null || echo "  Not available"
}

# Clean function
aider-clean() {
    find . -maxdepth 1 -type f -name "--system_prompt*" -exec rm -f -- {} +
    rm -f /tmp/aider-debug.log 2>/dev/null
    echo "🧹 Cleaned up stray system prompt files and debug logs"
}

# Help function (updated with debug commands)
aider-help() {
    echo "Aider Functions (Environment Variable Based)"
    echo "============================================"
    echo "Available commands:"
    echo "  aider-bash     - Bash scripting expert"
    echo "  aider-code     - Full Stack Engineer"
    echo "  aider-docs     - Technical documentation"
    echo "  aider-arch     - Software architecture"
    echo "  aider-user     - User documentation"
    echo "  aider-legal    - Legal documents"
    echo "  aider-devops   - DevOps expert"
    echo "  aider-refactor - Code refactoring"
    echo "  aider-silent   - Minimal output, code only"
    echo "  aider-reason   - Step-by-step reasoning"
    echo "  aider-flutter  - Flutter expert"
    echo "  aider-react    - React/TypeScript expert"
    echo "  aider-test     - Testing expert"
    echo "  aider-auto     - Automation expert"
    echo ""
    echo "Debug Commands:"
    echo "  aider-debug        - Show debug information about all personalities"
    echo "  aider-debug-run    - Run a personality with verbose output"
    echo "  aider-debug-check  - Check if a personality function exists"
    echo "  aider-clean        - Clean up temp files"
    echo ""
    echo "Usage: aider-<command> [arguments]"
    echo "Example: aider-flutter 'Create a login form'"
    echo "         aider-debug-run flutter 'Create a button'"
}

echo "✅ Aider functions loaded. Run aider-help for list of commands."