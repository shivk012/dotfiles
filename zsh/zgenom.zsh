# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"
zgenom autoupdate

if ! zgenom saved; then
    echo "Creating a zgenom save"

    zgenom compdef

    zgenom ohmyzsh plugins/git

    # zgenom load nvm 

    zgenom load zsh-users/zsh-history-substring-search 

    zgenom load mroth/evalcache
    zgenom load Aloxaf/fzf-tab
    zgenom load romkatv/zsh-defer

    # completions
    zgenom load zsh-users/zsh-completions

    zgenom load zsh-users/zsh-syntax-highlighting
    # save all to init script
    zgenom save

    # Compile your zsh files
    zgenom compile "$HOME/.zshrc"
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

