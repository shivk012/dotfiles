# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# no trigger for completion just press tab
# export FZF_COMPLETION_TRIGGER=''

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Options for path completion (e.g. vim **<TAB>)
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'

# Options for directory completion (e.g. cd **<TAB>)
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

# Advanced customization of fzf options via _fzf_comprun function
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

