#!/bin/sh
. $MUNIN_LIBDIR/plugins/plugin.sh

if [ "$1" = "autoconf" ]; then
        echo yes
        exit 0
fi

if [ "$1" = "config" ]; then

        echo 'graph_title Load average'
        echo 'graph_args --base 1000 -l 0'
        echo 'graph_vlabel load'
        echo 'graph_scale no'
        echo 'graph_category system'
        echo 'load.label load'
        print_warning load
        print_critical load
        echo 'graph_info The load average of the machine describes how many processes are in the run-queue (scheduled to run "immediately").'
        echo 'load.info 5 minute load average'
        exit 0
fi

echo -n "load.value "
cut -f2 -d' ' < /proc/loadavg
