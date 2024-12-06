# Prüfen, ob tmux bereits läuft
if not set -q TMUX
    # Startet eine neue tmux-Session mit einem eindeutigen Namen basierend auf der PID
    echo "NEW TMUX SESSION"
    set tmux_session_name "session_$fish_pid"
    tmux new-session -s $tmux_session_name && exit
end


tmux list-sessions | grep -v attached | cut -d: -f1 |  xargs -t -n1 tmux kill-session -t

set PATH /home/alex/.nvm/versions/node/v20.15.1/bin $PATH
