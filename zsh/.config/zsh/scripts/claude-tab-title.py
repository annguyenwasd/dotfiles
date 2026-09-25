#!/usr/bin/env python3

import hashlib
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path


def summary_path(session_id):
    if not session_id:
        return None
    session_key = hashlib.sha256(session_id.encode()).hexdigest()
    return Path(tempfile.gettempdir()) / f"claude-tab-title-{os.getuid()}" / session_key


def goal_summary(text):
    return " ".join(re.findall(r"[\w'-]+", text, re.UNICODE)[:10])


def main():
    event = json.load(sys.stdin)
    if event.get("agent_id"):
        return 0

    event_name = event.get("hook_event_name")
    state = summary_path(event.get("session_id"))
    if event_name == "SessionEnd":
        if state:
            state.unlink(missing_ok=True)
        return 0

    if event_name == "UserPromptSubmit" and (event.get("prompt") or "").lstrip().startswith("<"):
        return 0

    saved = goal_summary(state.read_text()) if state and state.is_file() else ""
    if saved.startswith(("cross-session-message", "task-notification")):
        saved = ""

    source = {
        "UserPromptSubmit": event.get("prompt", ""),
        "TaskCreated": event.get("task_subject", ""),
    }.get(event_name)
    if source is not None:
        summary = goal_summary(source)
        if summary.lower() in {"continue", "yes", "ok", "okay", "go ahead", "proceed"}:
            summary = saved
        if summary and state:
            state.parent.mkdir(mode=0o700, exist_ok=True)
            state.write_text(summary)
    elif event_name in {"CwdChanged", "Stop", "StopFailure"}:
        summary = saved
        if not summary:
            worktree_name = Path(event.get("new_cwd") or event.get("cwd") or os.getcwd()).name
            summary = goal_summary(f"Working on {worktree_name}")
    else:
        return 0

    if not summary:
        return 0

    cwd = event.get("new_cwd") or event.get("cwd") or os.getcwd()
    branch = subprocess.run(
        ["git", "-C", cwd, "symbolic-ref", "--short", "HEAD"],
        capture_output=True,
        text=True,
    ).stdout.strip()
    if not branch:
        branch = subprocess.run(
            ["git", "-C", cwd, "rev-parse", "--short", "HEAD"],
            capture_output=True,
            text=True,
        ).stdout.strip()
    branch = branch or "no-branch"
    branch = re.sub(r"[\x00-\x1f\x7f<>]", "", branch)
    title = f"{summary} ({branch})"
    print(json.dumps({"terminalSequence": f"\x1b]1;{title}\x07"}))
    return 0


if __name__ == "__main__":
    sys.exit(main())
