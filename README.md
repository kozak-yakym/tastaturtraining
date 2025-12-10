# tastaturtraining

Keyboard training script

This small project provides a terminal-based typing training application written in Python using `curses`.

**Features**
- Select training texts interactively with Up/Down and confirm with Enter.
- Optional mistake highlighting (correction ON/OFF).
- Desktop launcher and simple installer for Ubuntu.

**Included files**
- `tastaturtraining.py` — main program
- `Texts/` — sample text files
- `bin/run_tastaturtraining.sh` — wrapper to run from project directory
- `tastaturtraining.desktop` — local desktop entry
- `install.sh` — simple installer (installs to `/opt/tastaturtraining` and adds `/usr/local/bin/tastaturtraining`)
- `uninstall.sh` — removes installed files
- `create_package.sh` — create `tar.gz` package for deployment

## Quick run (development)
Run the script from the project directory so relative paths to `Texts/` work:

```bash
python3 tastaturtraining.py
```

## Install on another Ubuntu machine
1. Create a package locally (optional):

```bash
./create_package.sh
# copy tastaturtraining.tar.gz to target machine
```

2. On the target machine, extract or clone the repository and run the installer as root:

```bash
sudo ./install.sh
```

What `install.sh` does:
- Copies the project to `/opt/tastaturtraining` (using `rsync`).
- Installs `/usr/local/bin/tastaturtraining` so you can run it from terminal.
- Installs a desktop entry at `/usr/share/applications/tastaturtraining.desktop` (appears in Applications menu).
- Attempts to copy the `.desktop` to the invoking user's `~/Desktop` so you can double-click to launch (Ubuntu may require "Allow Launching").

## Uninstall
Run as root to remove installed files:

```bash
sudo ./uninstall.sh
```

## Notes and requirements
- Requires `python3` (Ubuntu typically ships it installed).
- The UI uses `curses` and runs inside a terminal — desktop launcher runs the script in a terminal window.
- If you need packaging as a `.deb` or additional dependency checks, open an issue or request and I'll add it.

## License
See `LICENSE` in the repository.
# tastaturtraining
Keyboard training script
