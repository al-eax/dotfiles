if status is-interactive 
and not set -q TMUX
    tmux attach -t home || tmux new -s home
end
clear


set PATH /home/alex/.nvm/versions/node/v20.15.1/bin $PATH
