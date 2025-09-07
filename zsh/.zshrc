# zmodload zsh/zprof # use this for profiling

# work out directory of original file so that only the main .zshrc file needs to be symlinked
DIR=$(dirname $(readlink ~/.zshrc))

source $DIR/history.zsh
source $DIR/work.zsh
source $DIR/alias.zsh
source $DIR/fzf.zsh
source $DIR/zgenom.zsh
source $DIR/nvm.zsh

_evalcache starship init zsh 

_evalcache zoxide init zsh

_evalcache mise activate zsh

# pipx
export PATH="$PATH:/Users/shivam.kumar/.local/bin"

export PYTHONBREAKPOINT=ipdb.set_trace

# opencode
export PATH="$PATH:/Users/shivam.kumar/.opencode/bin"

# zprof # use this for profiling
