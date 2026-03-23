#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.12"
# dependencies = [
#   "i3ipc",
# ]
# ///

from __future__ import annotations
import subprocess
import random
from pathlib import Path
from collections import defaultdict
from i3ipc import Connection, Event


def _get_all_wallpapers():
    img_suff = {".jpg", ".png", ".jpeg"}
    return [p for p in WALLPAPER_PATH.glob("*") if p.suffix.lower() in img_suff]

def _get_random_wallpaper():
    wp = random.choice(WALLPAPERS)
    return wp

def _set_wallpaper(workspace: str):
    _ = subprocess.run([
        "feh",
        "--bg-fill",
        str(workspace_wallpapers[workspace])
    ])

def on_ws_focus(i3, e):
    if e.current and e.current.name:
        ws = e.current.name
        _set_wallpaper(ws)

def on_ws_empty(i3, e):
    if e.current and e.current.name:
        ws = e.current.name
        _ = workspace_wallpapers.pop(ws)

def main():
    i3 = Connection()
    current_ws = i3.get_tree().find_focused()
    if current_ws and current_ws.workspace():
        _set_wallpaper(current_ws.workspace().name)
    i3.on(Event.WORKSPACE_FOCUS, on_ws_focus)
    i3.on(Event.WORKSPACE_EMPTY, on_ws_empty)
    i3.main()

WALLPAPER_PATH: Path = Path.home() / Path("Wallpapers")
WALLPAPERS = _get_all_wallpapers() # Cache once on launch. 
workspace_wallpapers = defaultdict(_get_random_wallpaper)

if __name__ == "__main__":
    if WALLPAPERS: # Only run if our wallpaper folder has actual wallpapers found.
        main()
    else:
        prefix = "[I3_WP_Cycle]: "
        print(f"{prefix}Error no wallpapers in {WALLPAPER_PATH}\n{prefix}Shutting down.")
