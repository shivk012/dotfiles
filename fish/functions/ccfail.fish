function ccfail --description 'fzf CircleCI jobs for a branch: job -> step -> log'
    # Usage:
    #   ccfail            # runs on the current branch
    #   ccfail <branch>   # runs on a specific branch
    #
    # Chain: run list -> workflow list -> workflow get (jobs) -> job output.
    # Project is inferred from the git remote by the circleci CLI.

    for bin in circleci fzf jq
        if not type -q $bin
            echo "ccfail: missing dependency '$bin'" >&2
            return 1
        end
    end

    set -l branch_args -B
    if test (count $argv) -ge 1
        set branch_args --branch $argv[1]
    end

    # 1. Pick a run for the branch.
    set -l run (circleci run list $branch_args --limit 20 --json 2>/dev/null \
        | jq -r '.[] | "\(.id)\t\(.current_outcome // .outcome // .phase)\t\(.commit.subject)"' \
        | fzf --with-nth=2.. --delimiter='\t' \
              --header='Select a run (esc to cancel)' \
        | cut -f1)
    test -n "$run"; or begin; echo "ccfail: no run selected" >&2; return 1; end

    # 2. Gather every job across the run's workflows.
    #    Line format: <job-uuid>\t<outcome>\t<workflow> / <job-name>
    set -l jobs
    for wf in (circleci workflow list "$run" --json 2>/dev/null | jq -r '.[].id')
        set -l wfname (circleci workflow get "$wf" --json 2>/dev/null | jq -r '.name')
        set -l lines (circleci workflow get "$wf" --json 2>/dev/null \
            | jq -r --arg wf "$wfname" \
                '.jobs[] | select(.type != "approval")
                 | "\(.id)\t\(.current_outcome // .outcome // .phase)\t\($wf) / \(.name)"')
        set jobs $jobs $lines
    end
    test -n "$jobs"; or begin; echo "ccfail: no jobs found for run" >&2; return 1; end

    # 3. Pick a job (failed jobs pre-filtered into the query; clear to see all).
    set -l job (printf '%s\n' $jobs \
        | fzf --with-nth=2.. --delimiter='\t' \
              --query='failed ' \
              --header='Select a job (query preset to failed; clear to see all)' \
        | cut -f1)
    test -n "$job"; or begin; echo "ccfail: no job selected" >&2; return 1; end

    # 4. Pick a step (failed steps pre-filtered into the query).
    set -l step (circleci job output list "$job" --json 2>/dev/null \
        | jq -r '.steps[] | "\(.num)\t\(.outcome)\texit=\(.exit_code // "-")\t\(.name)"' \
        | fzf --with-nth=2.. --delimiter='\t' \
              --query='failed ' \
              --header='Select a step (query preset to failed; clear to see all)' \
        | cut -f1)
    test -n "$step"; or begin; echo "ccfail: no step selected" >&2; return 1; end

    # 5. Dump the step's log (paged if interactive).
    if isatty stdout
        circleci job output get "$job" --step-num "$step" | less -R
    else
        circleci job output get "$job" --step-num "$step"
    end
end
