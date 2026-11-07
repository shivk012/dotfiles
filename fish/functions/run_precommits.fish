#!/usr/bin/env fish
#
# Usage:
#   run_precommits [N]
#
# Arguments:
#   N  Number of recent commits to check 
#
function run_precommits -d "Run pre-commit hooks on the last N commits" -a N
    if test (count $argv) -ge 1
        if string match -qr '^\d+$' -- $argv[1]
            set num_commits $argv[1]
        else
            echo "Error: argument must be a positive integer, got: $argv[1]"
            exit 1
        end
    end
    # Collect the last N commit SHAs in oldest-first order
    set commits (git log --format="%H" -n $num_commits | tail -r)
    if test (count $commits) -eq 0
        echo "No commits found."
        exit 1
    end
    echo "Running pre-commit hooks on $num_commits commit(s)..."
    echo ""
    set pass_count 0
    set fail_count 0
    set failed_commits
    for sha in $commits
        set subject (git log -1 --format="%s" $sha)
        echo "── $sha  $subject"
        pre-commit run --from=$sha^1 --to=$sha
        set exit_code $status
        if test $exit_code -eq 0
            set pass_count (math $pass_count + 1)
            echo "   ✓ passed"
        else
            set fail_count (math $fail_count + 1)
            set failed_commits $failed_commits $sha
            echo "   ✗ failed (exit $exit_code)"
        end
        echo ""
    end
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Results: $pass_count passed, $fail_count failed"
    if test $fail_count -gt 0
        echo ""
        echo "Failed commits:"
        for sha in $failed_commits
            echo "  $sha  "(git log -1 --format="%s" $sha)
        end
    end
end
