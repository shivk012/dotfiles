# zmodload zsh/zprof # use this for profiling
# work out directory of original file so that only the main .zshrc file needs to be symlinked
DIR=$(dirname $(readlink ~/.zshrc))

DISABLE_AUTO_UPDATE="true"
export PATH="/opt/homebrew/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:fzf-tab' lazy yes
plugins=(
  fzf-tab 
  git 
  evalcache 
  zsh-fzf-history-search
  nvm
)
source $ZSH/oh-my-zsh.sh
_evalcache starship init zsh

# styling for fzf-tab 
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"
_evalcache pyenv init - --no-rehash zsh

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
pyenv virtualenvwrapper_lazy

# RabbitMQ
export PATH="/usr/local/sbin:$PATH"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


_complete_invoke() {
    # `words` contains the entire command string up til now (including
    # program name).
    #
    # We hand it to Invoke so it can figure out the current context: spit back
    # core options, task names, the current task's options, or some combo.
    #
    # Before doing so, we attempt to tease out any collection flag+arg so we
    # can ensure it is applied correctly.
    collection_arg=''
    if [[ "${words}" =~ "(-c|--collection) [^ ]+" ]]; then
        collection_arg=$MATCH
    fi
    # `reply` is the array of valid completions handed back to `compctl`.
    # Use ${=...} to force whitespace splitting in expansion of
    # $collection_arg
    reply=( $(invoke ${=collection_arg} --complete -- ${words}) )
}

# Tell shell builtin to use the above for completing our given binary name(s).
# * -K: use given function name to generate completions.
# * +: specifies 'alternative' completion, where options after the '+' are only
#   used if the completion from the options before the '+' result in no matches.
# * -f: when function generates no results, use filenames.
# * positional args: program names to complete for.
compctl -K _complete_invoke + -f invoke inv

# vim: set ft=sh :

export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

# HISTORY
source $DIR/history.sh

alias ls='eza'
alias cat='bat'

alias note='cd ~/Documents/Notes/ && nvim ~/Documents/Notes/'

alias fixup='print -z -- git commit --fixup $(git log -n 10 --no-merges --pretty="%h %s" | fzf | cut  -c -7)'

alias aliasfzf='print -z -- $(alias | fzf | sed "s/\=.*//")'

function autosquash() {
    local num=$1
    git rebase --autosquash HEAD~$num -i
}
function db_setting() {
  print -z -- "all-dbs \"select key, value, created_at from \\\"config_setting\\\" where key = '$1' LIMIT 1\""
}


# pipx
export PATH="$PATH:/Users/shivam.kumar/.local/bin"
# Smarter completion initialization
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi
# eval "$(register-python-argcomplete pipx)"
_evalcache register-python-argcomplete pipx

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# enable-fzf-tab
source <(fzf --zsh)

# zoxide
eval "$(zoxide init zsh)"

# tmuxifier
export PATH="$PATH:$HOME/.tmux/plugins/tmuxifier/bin"
_evalcache tmuxifier init -

# ipython pdb
export PYTHONBREAKPOINT=ipdb.set_trace

_evalcache thefuck --alias fk

alias theshiv='git add . && git commit --amend --no-edit && git push -f'

alias open_pr='gh pr view $(gh pr list --repo octoenergy/kraken-core --search "is:pr reviewed-by:@me -author:@me is:closed" | fzf | cut -f 1) -w'

alias last_edited='nvim $(git log --pretty=format: --name-only -n 1 | cut -c 5-)'
alias edited='nvim $(git diff --name-only | cut -c 5-)'

# Work specific ones 
source $DIR/work.sh

# zprof # use this for profiling

# opencode
export PATH="$PATH:/Users/shivam.kumar/.opencode/bin"
