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

function iterm_set_title() {
  [[ $TERM_PROGRAM == "iTerm.app" ]] || return
  printf '\033]1;%s\007' "$1"
}

# Shell function to quickly open the agent (function takes precedence over /usr/bin/cc)
function cc() {
  source "$HOME/workspace/secrets/.ds" || return $?
  # Jev decision-model key. Raw value, not sourceable; the jev skill's curl reads it here.
  export JEV_API_KEY="$(cat "$HOME/workspace/secrets/.jev")"
  iterm_set_title "Claude · ${PWD:t}"
  claude --dangerously-skip-permissions "$@"
}

function ccd() {
  export JEV_API_KEY="$(cat "$HOME/workspace/secrets/.jev")"
  CODEX_HOME="$HOME/.codex-openai" codex --dangerously-bypass-approvals-and-sandbox "$@"
}

# Claude Code on z.ai: GLM-5.3 main + GLM-5.3-Flash background, 1M context.
# Key: raw string in ~/workspace/secrets/.zai (get one at https://z.ai → API Keys)
function ccz() {
  local zai_key="$(cat "$HOME/workspace/secrets/.zai" 2>/dev/null)"
  if [[ -z "$zai_key" ]]; then
    echo "Missing z.ai key: paste it into ~/workspace/secrets/.zai"
    return 1
  fi
  export JEV_API_KEY="$(cat "$HOME/workspace/secrets/.jev")"
  iterm_set_title "Claude · ${PWD:t}"
  ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic" \
  ANTHROPIC_AUTH_TOKEN="$zai_key" \
  ANTHROPIC_MODEL="glm-5.3-flash[1m]" \
  ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-5.3-flash[1m]" \
  ANTHROPIC_DEFAULT_SONNET_MODEL="glm-5.3[1m]" \
  ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5.3[1m]" \
  ANTHROPIC_DEFAULT_OPUS_FABEL="glm-5.3[1m]" \
  CLAUDE_CODE_SUBAGENT_MODEL="glm-5.3-flash[1m]" \
  API_TIMEOUT_MS="3000000" \
  claude --dangerously-skip-permissions "$@"
}
