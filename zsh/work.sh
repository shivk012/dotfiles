alias gbr-dbs='all-dbs --clients oegb,edfgb,eonnext,goodenergy '
alias invfzf='print -z -- inv $(inv --list | cut -d " " -f 3 | sed "/^$/d" | fzf --preview="inv -h={}")'

function clear_db() {
	unset DATABASE_NAME
	unset DATABASE_USER
	unset DATABASE_HOST
	unset DATABASE_PASSWORD
	unset DATABASE_REPLICA_HOST
	unset FORCE_SUPPORT_SITE_USER_ID
}

alias test='inv localdev.pytest'
export KRAKEN_DB_PG_CLIENT=harlequin
