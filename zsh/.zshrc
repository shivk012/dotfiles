zmodload zsh/zprof # use this for profiling

# work out directory of original file so that only the main .zshrc file needs to be symlinked
DIR=$(dirname $(readlink ~/.zshrc))

source $DIR/zgenom.zsh
zsh-defer source $DIR/fzf.zsh
zsh-defer source $DIR/history.zsh
zsh-defer source $DIR/work.zsh
zsh-defer source $DIR/alias.zsh
# zsh-defer source $DIR/nvm.zsh

_evalcache starship init zsh 

zsh-defer _evalcache zoxide init zsh

zsh-defer _evalcache mise activate zsh

# pipx
export PATH="$PATH:/Users/shivam.kumar/.local/bin"

export PYTHONBREAKPOINT=ipdb.set_trace

# opencode
export PATH="$PATH:/Users/shivam.kumar/.opencode/bin"

zprof # use this for profiling
