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

# formatting for the pretty colors 
starship init fish | source

abbr --add open_pr 'gh pr view $(gh pr list --repo octoenergy/kraken-core --search "is:pr reviewed-by:@me -author:@me is:closed" | fzf | cut -f 1) -w'

abbr --add last_edited 'nvim $(git log --pretty=format: --name-only -n 1 | cut -c 5-)'

abbr --add edited 'nvim $(git diff --name-only | cut -c 5-)'

function fixup -d "Interactive fixup"
    set -l commit_hash (git log -n 20 --no-merges --pretty="%h %s" | fzf | cut -c -7)
    commandline --replace "git commit --fixup $commit_hash"
end

# Function to search abbreviations and insert the command into the prompt
function aliasfzf -d "Find abbrs"
    set -l cmd (abbr --show | fzf | string match -r --groups-only "'([^']+)'|(\S+)\$" )
    commandline --replace -- "$cmd"
end

function autosquash -d "Perform interactive rebase with --autosquash" -a num
    # Check if the 'num' argument was provided.
    if test -z "$num"
        echo "Error: Please provide the number of commits to look back." >&2
        echo "Usage: autosquash <number>"
        return 1
    end

    # Execute the git command.
    git rebase --autosquash "HEAD~$num" -i
end

abbr --add test 'inv localdev.pytest'

function invfzf
    set -l cmd (inv --list | cut -d " " -f 3 | sed "/^\$/d" | fzf --preview="inv -h={}")
    commandline --replace -- "inv $cmd"
end

abbr --add queries "rg -tpy -l 'deprecated_allow_too_many_queries' src/ | xargs -I {} codeowners {} | rg uk-initiatives"
abbr --add debt "rg -tpy -l '# (?:type:ignore|noqa|needs attention)' src/ | xargs -I {} codeowners {} | rg uk-initiatives"
