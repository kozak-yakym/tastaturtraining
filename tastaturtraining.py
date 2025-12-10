import curses
import os
import locale

# Enable system UTF-8 locale
locale.setlocale(locale.LC_ALL, "")

def get_text_files(directory):
    """Return all .txt files from the given directory."""
    return [f for f in os.listdir(directory) if f.endswith(".txt")]

def read_file_lines(file_path):
    """Read file and return list of lines."""
    with open(file_path, "r", encoding="utf-8") as f:
        return f.readlines()

def typing_training(stdscr, lines, highlight_mistakes):
    """Main typing training loop."""
    current_line = 0
    typed_text = ""

    while current_line < len(lines):
        stdscr.clear()

        stdscr.addstr(0, 0, "Typing Training (ESC to quit)", curses.A_BOLD)
        stdscr.addstr(2, 0, lines[current_line].rstrip("\n"), curses.A_BOLD)
        stdscr.addstr(4, 0, typed_text)

        # Highlight mistakes if enabled
        if highlight_mistakes:
            for i, c in enumerate(typed_text):
                if i < len(lines[current_line]) and c != lines[current_line][i]:
                    stdscr.addstr(4, i, c, curses.color_pair(1))

        stdscr.refresh()

        key = stdscr.get_wch()

        if isinstance(key, str):
            if key == '\n':  # ENTER always moves to next line
                current_line += 1
                typed_text = ""
            elif key == '\x1b':  # ESC
                return
            elif key in ('\x7f', '\b'):  # Backspace
                typed_text = typed_text[:-1]
            else:
                typed_text += key  # Add normal Unicode character

        elif isinstance(key, int):
            if key == curses.KEY_BACKSPACE:
                typed_text = typed_text[:-1]
            elif key == curses.KEY_DOWN:
                current_line += 1
                typed_text = ""

def main(stdscr):
    """Main menu and initialization."""
    curses.use_default_colors()
    curses.start_color()
    curses.init_pair(1, curses.COLOR_RED, curses.COLOR_BLACK)

    # --- Mode selection menu ---
    stdscr.clear()
    stdscr.addstr(0, 0, "Typing Training Mode Selection\n", curses.A_BOLD)
    stdscr.addstr(2, 0, "1. Correction ON (highlight mistakes)")
    stdscr.addstr(3, 0, "2. Correction OFF (no highlighting)")
    stdscr.addstr(5, 0, "Select mode (1 or 2): ")
    stdscr.refresh()

    mode_key = stdscr.get_wch()
    highlight_mistakes = True  # default

    if isinstance(mode_key, str) and mode_key.isdigit():
        if mode_key == '1':
            highlight_mistakes = True
        elif mode_key == '2':
            highlight_mistakes = False

    # --- File selection menu ---
    stdscr.clear()
    stdscr.addstr(0, 0, "Select a file for training:\n", curses.A_BOLD)

    text_files = get_text_files("./Texts")

    if not text_files:
        stdscr.addstr(2, 0, "No .txt files found inside 'Texts' folder.")
        stdscr.refresh()
        stdscr.getch()
        return

    # Display file list
    for i, file_name in enumerate(text_files):
        stdscr.addstr(i + 2, 0, f"{i + 1}. {file_name}")
    stdscr.refresh()

    selection = stdscr.get_wch()

    if isinstance(selection, str) and selection.isdigit():
        idx = int(selection) - 1
        if 0 <= idx < len(text_files):
            selected_file = text_files[idx]
            file_path = os.path.join("Texts", selected_file)
            lines = read_file_lines(file_path)
            typing_training(stdscr, lines, highlight_mistakes)

if __name__ == "__main__":
    os.makedirs("Texts", exist_ok=True)
    curses.wrapper(main)
