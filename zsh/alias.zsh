alias theshiv='git add . && git commit --amend --no-edit && git push -f'

alias open_pr='gh pr view $(gh pr list --repo octoenergy/kraken-core --search "is:pr reviewed-by:@me -author:@me is:closed" | fzf | cut -f 1) -w'

alias last_edited='nvim $(git log --pretty=format: --name-only -n 1 | cut -c 5-)'

alias edited='nvim $(git diff --name-only | cut -c 5-)'

alias ls='eza'

alias cat='bat'

alias note='cd ~/Documents/Notes/ && nvim ~/Documents/Notes/'

alias fixup='print -z -- git commit --fixup $(git log -n 10 --no-merges --pretty="%h %s" | fzf | cut  -c -7)'

alias aliasfzf='print -z -- $(alias | fzf | sed "s/\=.*//")'

function autosquash() {
	local num=$1
	git rebase --autosquash HEAD~$num -i
}
