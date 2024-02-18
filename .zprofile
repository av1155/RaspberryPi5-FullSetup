# Automatically attach to tmux session or create a new one called 'main'
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
    # Check if inside a tmux session already, and if not, proceed
    if tmux list-sessions &>/dev/null; then
        # If there are existing sessions, attach to the first one found
        # Replace this line with specific session attachment if preferred
        tmux attach-session -t $(tmux list-sessions -F "#S" | head -n 1)
    else
        # No sessions found, create a new one named 'main'
        tmux new-session -s main -d
        tmux attach-session -t main
    fi

    tmux source-file ~/.config/tmux/tmux.conf
fi

# <=================== NEOFETCH ====================>

command -v neofetch &>/dev/null && neofetch
