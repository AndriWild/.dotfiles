#!/bin/zsh

# inspired by theprimeagen 
if [[ $# -eq 1 ]]; then
    selected=$1
else

directories=(
  $(find ~/ -mindepth 0 -maxdepth 0 -type d)
  $(find ~/fhnw/6-Semester/ -mindepth 2 -maxdepth 2 -type d)
  $(find ~/fhnw/6-Semester/apm/ -mindepth 2 -maxdepth 2 -type d)
  $(find ~/fhnw -mindepth 1 -maxdepth 2 -type d)
  $(find ~/repos/ -mindepth 1 -maxdepth 1 -type d)
  $(find ~/.config/ -mindepth 1 -maxdepth 1 -type d)
  $(find ~/.local/bin/ -mindepth 1 -maxdepth 2 -type d)
) 
selected=$(echo $directories | tr " " "\n" | fzf)

fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _) # select the last path element 
tmux_running=$(ps -e | grep tmux)

# create new session if it a session with this name does not exist
if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -z $TMUX ]]; then  
  tmux attach -t $selected_name
else 
  tmux switch-client -t $selected_name
fi
