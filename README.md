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

## Simple deploy (recommended)
If you want the absolutely simplest deployment (no installers, no system paths), do this on the target machine:

1. Copy the whole project folder to the target machine (e.g. `/home/you/pyprojects/tastaturtraining`).

2. Make the included launcher executable (one-time):

```bash
chmod +x /home/you/pyprojects/tastaturtraining/run.sh
```

3. Create a Desktop shortcut: copy this file to `~/Desktop/tastaturtraining.desktop` and ensure it's executable.

Example `tastaturtraining.desktop` (update the paths to your user):

```ini
[Desktop Entry]
Type=Application
Name=TastaturTraining
Comment=Run Tastatur Training (terminal)
Exec=/home/you/pyprojects/tastaturtraining/run.sh
Icon=utilities-terminal
Terminal=true
Categories=Utility;
StartupNotify=true
```

4. Allow launching (if GNOME asks): right-click the desktop file and choose "Allow Launching" or make it executable:

```bash
chmod +x ~/Desktop/tastaturtraining.desktop
```

This approach keeps deployment minimal: you only copy the folder and point the desktop launcher at `run.sh` (which ensures the program runs from the project directory so `./Texts` is found).

## License
See `LICENSE` in the repository.
# tastaturtraining
Keyboard training script
