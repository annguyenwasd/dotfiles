# ============================================================================
# Agent Environment Variables
# ============================================================================
# These environment variables are used by .vimrc to abstract away the specific
# AI agent tool (cursor, opencode, copilot, etc.) from the keybindings.
#
# VIM_AGENT_COMMIT_COMMAND:
#   The shell command used to auto-commit via an AI agent.
#   Used in vim with :Dispatch! <command> "prompt..."
#
# VIM_AGENT_INTERACTIVE_COMMAND:
#   The terminal buffer name pattern for the interactive agent session.
#   The leading "!" matches vim's terminal buffer naming convention.
#   Used to find/reuse an existing agent terminal or spawn a new one.
# ============================================================================

export VIM_AGENT_COMMIT_COMMAND="cursor agent -p --force"
export VIM_AGENT_INTERACTIVE_COMMAND="!cursor agent"

# Shell alias to quickly open the agent
alias cc="cursor agent"
