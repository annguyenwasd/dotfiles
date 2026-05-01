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

export VIM_AGENT_COMMIT_COMMAND="claude -p"
export VIM_AGENT_INTERACTIVE_COMMAND="!claude --dangerously-skip-permissions"

# Shell function to quickly open the agent (function takes precedence over /usr/bin/cc)
function cc() { claude --dangerously-skip-permissions "$@" }

function gg() { gemini --yolo "$@" }

alias ag1="antigravity --user-data-dir ~/.config/antigravity_profiles/acc1"
alias ag2="antigravity --user-data-dir ~/.config/antigravity_profiles/acc2"
alias ag3="antigravity --user-data-dir ~/.config/antigravity_profiles/acc3"
alias ag4="antigravity --user-data-dir ~/.config/antigravity_profiles/acc4"

# Gemini CLI Auto-Rotate Aliases
alias gg1='GEMINI_API_KEY=$(cat ~/.config/gemini-keys/acc1) gemini --yolo'
alias gg2='GEMINI_API_KEY=$(cat ~/.config/gemini-keys/acc2) gemini --yolo'
alias gg3='GEMINI_API_KEY=$(cat ~/.config/gemini-keys/acc3) gemini --yolo'
alias gg4='GEMINI_API_KEY=$(cat ~/.config/gemini-keys/acc4) gemini --yolo'
