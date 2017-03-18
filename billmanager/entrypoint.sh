#!/bin/sh

[ -z "${TERM}" ] && export TERM=xterm

func_TERM() {
    service cron stop
    service ihttpd stop
    service mysql stop
    service ssh stop
    exit 0
}

trap func_TERM TERM INT

case $1 in

    start|billmgr)
	service ssh start
	service mysql start
	service cron start
	service ihttpd start

	shift
	exec $0 daemon
    ;;
    daemon)
	while true; do
	    sleep 10 &
	    wait $!
	done
    ;;
    *)
	exec $@
    ;;
esac
