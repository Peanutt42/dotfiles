#!/usr/bin/env python3

# MODIFIED FROM: https://github.com/niri-wm/niri/discussions/1599

"""
Like open-float, but dynamically. Floats a window when it matches the rules.

Some windows don't have the right title and app-id when they open, and only set
them afterward. This script is like open-float for those windows.

Usage: fill in the RULES array below, then run the script.
"""

from dataclasses import dataclass, field
import json
import os
import sys
import re
from socket import AF_UNIX, SHUT_WR, socket
import time
import atexit


@dataclass(kw_only=True)
class Match:
    title: str | None = None
    app_id: str | None = None

    def matches(self, window):
        if self.title is None and self.app_id is None:
            return False

        matched = True

        if self.title is not None:
            matched &= re.search(self.title, window["title"]) is not None
        if self.app_id is not None:
            matched &= re.search(self.app_id, window["app_id"]) is not None

        return matched


@dataclass
class Rule:
    match: list[Match] = field(default_factory=list)
    exclude: list[Match] = field(default_factory=list)
    override_width: int = None
    override_height: int = None
    center: bool = False

    def matches(self, window):
        if len(self.match) > 0 and not any(m.matches(window) for m in self.match):
            return False
        if any(m.matches(window) for m in self.exclude):
            return False

        return True


# Write your rules here. One Rule() = one window-rule {}.
RULES = [
    Rule(
        [
            Match(title=r"Extension: \(Bitwarden Password Manager\)", app_id="^app.zen_browser.zen$"),
            Match(title=r"Extension: \(Bitwarden Password Manager\)", app_id="firefox$")
        ],
        override_width = 544,
        override_height = 606,
        center = True
    )
]


if len(RULES) == 0:
    print("fill in the RULES list, then run the script")
    exit()

log_path = os.environ.get("LOG", "/tmp/niri-dynamic-open-float.log")
log_file = open(log_path, "w", buffering=1, encoding="utf-8")
sys.stdout = log_file
sys.stderr = log_file
atexit.register(log_file.close)
print(f"=== Started: PID={os.getpid()} ===")

niri_socket = socket(AF_UNIX)
niri_socket.connect(os.environ["NIRI_SOCKET"])
file = niri_socket.makefile("rw")

_ = file.write('"EventStream"')
file.flush()
niri_socket.shutdown(SHUT_WR)

windows = {}


def send(request):
    with socket(AF_UNIX) as niri_socket:
        data = json.dumps(request) + "\n"
        print("  Sending: " + data, end="")

        niri_socket.connect(os.environ["NIRI_SOCKET"])
        niri_socket.sendall(data.encode("utf-8"))

        try:
            niri_socket.shutdown(SHUT_WR)
        except OSError:
            pass
        # read one line response
        reply = b""
        while True:
            chunk = niri_socket.recv(4096)
            if not chunk:
                break
            reply += chunk
            if b"\n" in reply:
                break

    if not reply:
        print("    -> No reply", file=sys.stderr)
        return

    line = reply.splitlines()[0].decode("utf-8", errors="replace")

    try:
        parsed = json.loads(line)
    except Exception:
        print("    -> Raw reply:", line)
        return

    print("    -> Reply: " + json.dumps(parsed))

def float(id: int):
    send({"Action": {"MoveWindowToFloating": {"id": id}}})

def set_width(id: int, width: int):
    send({"Action": {"SetWindowWidth": {"id": id, "change": {"SetFixed": width}}}})

def set_height(id: int, height: int):
    send({"Action": {"SetWindowHeight": {"id": id, "change": {"SetFixed": height}}}})

def center_floating(id: int):
    send({"Action": {"CenterWindow": {"id": id}}})


def update_matched(win):
    win["matched"] = False
    if existing := windows.get(win["id"]):
        win["matched"] = existing["matched"]

    matched_before = win["matched"]
    matched_rule = next((r for r in RULES if r.matches(win)), None)
    win["matched"] = matched_rule is not None
    if win["matched"] and not matched_before:
        print(f"{matched_rule}\n  matched for title='{win['title']}', app_id='{win['app_id']}'")
        float(win["id"])
        if matched_rule.override_width is not None:
            set_width(win["id"], matched_rule.override_width)
        if matched_rule.override_height is not None:
            set_height(win["id"], matched_rule.override_height)
        if matched_rule.center:
            # needed for the window layout to settle (i dont like this too)
            if matched_rule.override_width is not None or matched_rule.override_height is not None:
                time.sleep(0.1)
            center_floating(win["id"])

for line in file:
    event = json.loads(line)

    if changed := event.get("WindowsChanged"):
        for win in changed["windows"]:
            update_matched(win)
        windows = {win["id"]: win for win in changed["windows"]}
    elif changed := event.get("WindowOpenedOrChanged"):
        win = changed["window"]
        update_matched(win)
        windows[win["id"]] = win
    elif changed := event.get("WindowClosed"):
        del windows[changed["id"]]
