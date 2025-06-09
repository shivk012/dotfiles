export PATH="/opt/homebrew/bin:$PATH"
eval "$(starship init zsh)"
export ZSH="$HOME/.oh-my-zsh"

export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
plugins=(fzf-tab git zsh-nvm evalcache zsh-fzf-history-search
)
source $ZSH/oh-my-zsh.sh

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

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"
_evalcache pyenv init -

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
pyenv virtualenvwrapper_lazy

# RabbitMQ
export PATH="/usr/local/sbin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


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
export HISTSIZE=100000
export HISTFILE=/Users/shivam.kumar/.zsh_history
export SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
# END HISTORY

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
autoload -U compinit && compinit
eval "$(register-python-argcomplete pipx)"


# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
enable-fzf-tab

# zoxide
eval "$(zoxide init zsh)"

# tmuxifier
export PATH="$PATH:$HOME/.tmux/plugins/tmuxifier/bin"
eval "$(tmuxifier init -)"

# ipython pdb
export PYTHONBREAKPOINT=ipdb.set_trace

eval $(thefuck --alias fk)

alias theshiv='git add . && git commit --amend --no-edit && git push -f'

# Work specific ones 
# TODO: Move these out 
alias gbr-dbs='all-dbs --clients oegb,edfgb,eonnext,goodenergy '
alias invfzf='print -z -- inv $(inv --list | cut -d " " -f 3 | sed "/^$/d" | fzf --preview="inv -h={}")'

function clear_db(){
  unset DATABASE_NAME
  unset DATABASE_USER
  unset DATABASE_HOST
  unset DATABASE_PASSWORD
  unset DATABASE_REPLICA_HOST
  unset FORCE_SUPPORT_SITE_USER_ID
}

alias test='inv localdev.pytest'
export KRAKEN_DB_PG_CLIENT=harlequin
# export PYTHONPATH='$PYTHONPATH:/Users/shivam.kumar/.virtualenvs/kraken-core/lib/python3.12/site-packages/:/Users/shivam.kumar/projects/kraken-core/src'

function shell_plus(){
  local client=$1
  local json_output
  json_output=$(ktdb connections get "$client-prod.krakencore" --reveal-password)
  DATABASE_PASSWORD=$(echo "$json_output" | jq -r '.password') \
  DATABASE_USER=$(echo "$json_output" | jq -r '.username') \
  DATABASE_HOST=$(echo "$json_output" | jq -r '.host') \
  DATABASE_PORT=$(echo "$json_output" | jq -r '.port') \
  DATABASE_NAME=$(echo "$json_output" | jq -r '.database') \
  DJANGO_SETTINGS_MODULE=octoenergy.settings \
  inv localdev.manage shell_plus --client $client
}
function supportsite(){
  local client=$1
  local json_output
  json_output=$(ktdb connections get "$client-prod.krakencore" --reveal-password)
  DATABASE_PASSWORD=$(echo "$json_output" | jq -r '.password') \
  DATABASE_USER=$(echo "$json_output" | jq -r '.username') \
  DATABASE_HOST=$(echo "$json_output" | jq -r '.host') \
  DATABASE_PORT=$(echo "$json_output" | jq -r '.port') \
  DATABASE_NAME=$(echo "$json_output" | jq -r '.database') \
  DJANGO_SETTINGS_MODULE=octoenergy.settings \
  inv supportsite.run --client $client
}
