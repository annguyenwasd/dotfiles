# Herdr keybinding migration from tmux

Herdr config lives at [`herdr/.config/herdr/config.toml`](./.config/herdr/config.toml), migrated from `tmux/.tmux.conf`. Install with `stow herdr --target=$HOME`, then reload the running server with `herdr server reload-config`.

Note: if `~/.config/herdr/config.toml` already exists (created by Herdr on first run), remove it before `stow herdr`, or use `stow --adopt` and diff afterwards.

## Migrated

| tmux | Herdr config | Notes |
| --- | --- | --- |
| `set -g prefix C-a` | `keys.prefix = "ctrl+a"` | `C-b` unbind is implied; Herdr has no send-prefix action. |
| `bind C-v split-window -h` | `split_vertical = ["prefix+ctrl+v", "prefix+v"]` | Default `prefix+v` kept as alias. |
| `bind C-s split-window -v` | `split_horizontal = ["prefix+ctrl+s", "prefix+minus"]` | Default `prefix+minus` kept. New panes inherit cwd (`terminal.new_cwd = "follow"` is the default, like `-c '#{pane_current_path}'`). |
| `bind c new-window -c cwd` | `new_tab = "prefix+c"` (default) | Same behavior with inherited cwd. |
| `bind -r C-h` / `C-l` select-window | `previous_tab` / `next_tab` arrays | Defaults `prefix+p` / `prefix+n` kept. |
| `bind -r H/J/K/L resize-pane` | `resize_pane_left/down/up/right = "prefix+shift+h/j/k/l"` | Collided with default `swap_pane_*`, so swap moved to `prefix+alt+h/j/k/l`. Fixed 5-column step replaced by Herdr's resize step. |
| `bind C-a copy-mode` | `copy_mode = ["prefix+ctrl+a", "prefix+"]` | Default `prefix+[` kept. |
| `bind C-e last-window` | `last_pane = "prefix+ctrl+e"` | Approximation: focuses the last focused pane instead of the last window. |
| `bind r source-file ~/.tmux.conf` | `reload_config = ["prefix+r", "prefix+shift+r"]` | Default `prefix+shift+r` kept; `resize_mode` moved to `prefix+alt+r` to free `prefix+r`. |
| vim-tmux-navigator `C-h/j/k/l` (root, prefix-free) | `focus_pane_* = ["prefix+h/j/k/l", "ctrl+alt+h/j/k/l"]` | Bare `ctrl+h/j/k/l` cannot be used prefix-free: shells own them (backspace, enter, kill-line, clear). `ctrl+alt+` is Herdr's vetted terminal-safe family. |
| copy-mode-vi `v` (selection), `y` (yank) | Built-in copy mode | `v`/`V` select, `y` copies to system clipboard. No config needed. |
| `set -g mode-keys vi` | Copy mode default | vi-style `h/j/k/l`, `w/b/e`, `/` search, `n/N`. |
| `set -g mouse on` | `ui.mouse_capture` default `true` | Mouse-native by default. |
| `set-option -g default-shell /bin/zsh` | `terminal.default_shell = "/bin/zsh"` | |
| `set -g history-limit 99999999` | `advanced.scrollback_limit_bytes = 100000000` | Different unit: bytes, not lines. |
| `set -g base-index 1` / `pane-base-index 1` | Nothing to set | Tabs/panes are addressed 1-based (`prefix+1..9`). |
| tmux-resurrect + tmux-continuum | Built-in persistence | Panes, layout, and supported agent sessions survive server restarts without plugins. |

## Not migrated

| tmux binding / setting | Reason |
| --- | --- |
| `bind-key C-a send-prefix` | No `send-prefix` action in Herdr. |
| `bind R movew -r` (renumber windows) | No tab-renumber action. |
| `bind o killp -a`, `bind O killw -a` | No "kill all others" action; only `close_pane` (`prefix+x`) and `close_tab` (`prefix+shift+x`). |
| `bind v/h/e select-layout main-vertical/main-horizontal/tiled` | Herdr has no named layout commands; resize panes manually or use plugins. |
| `bind c-p respawnw` | No respawn-pane action. |
| `bind V splitp -hbl 25%` | Split size percentage is not configurable per binding. |
| `bind Z zen.sh`, `bind u uzen.sh`, `bind w fzf_t_w.sh` | Scripts drive tmux itself (`tmux resize-pane`, `tmux list-windows`); they do not work against Herdr. Could be rewritten later as `[[keys.command]]` popup entries. |
| copy-mode-vi `C-h/j/k/l/\\` pane switching | Copy-mode navigation keys are not configurable. |
| Status bar / theme block (`status-*`, `window-status-*`, `pane-border-*`) | Different UI model: `[ui]` (tab bar, sidebar) and `[theme]` in Herdr. |
| `escape-time`, `focus-events`, `aggressive-resize`, `remain-on-exit`, `bell-action`, `visual-bell`, `display-time` | tmux-server internals with no Herdr equivalent. |
| TPM plugins: `tmux-open`, `tmux-fzf-url` | No direct port; see the Herdr plugin marketplace for alternatives. |
| `default-terminal` / `terminal-overrides` | Herdr manages terminal capabilities itself. |
