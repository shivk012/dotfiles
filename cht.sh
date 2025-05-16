# ~/usr/bin/env bash

languages=$(echo "python lua" | tr ' ' '\n')
core_utils=$(echo "xargs find mv sed awk" | tr ' ' '\n')

selected=$(printf "$languages\n$core_utils" | fzf)

if [[ -z $selected ]]; then
	exit 0
fi

read -p "Enter Query: " query

if printf $languages | grep -qs $selected; then
	query=$(echo $query | tr ' ' '+')
	tmux neww bash -c "curl -s cht.sh/$selected/$query | bat -p | less"
else
	tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
