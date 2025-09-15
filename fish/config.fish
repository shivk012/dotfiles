if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Disable the fish greeting message
set fish_greeting ""

# Print a new line after any command
source ~/.config/fish/functions/postexec_newline.fish

# `ls` → `ls -laG` abbreviation
abbr -a -g ls ls -laG

# `ls` → `exa` abbreviation
# Requires `brew install exa`
if type -q exa
    abbr --add -g ls 'exa --long --classify --all --header --git --no-user --tree --level 1'
end

# `cat` → `bat` abbreviation
# Requires `brew install bat`
if type -q bat
    abbr --add -g cat bat
end
