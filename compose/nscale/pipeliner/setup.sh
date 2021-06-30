#!/usr/bin/bash

readonly APPLICATION_LAYER_HOSTNAME=${APPLICATION_LAYER_HOSTNAME:-application-layer}

echo -e $(date '+%d-%b-%Y %H:%M:%S.%3N')" \e[34mWait for application layer...\e[39m"

while : ; do
    ncat --recv-only ${APPLICATION_LAYER_HOSTNAME} 20626 2> /dev/null | grep -q 'server is running'
    RESULT=$?
    if [ $RESULT -eq 0 ]; then

        write_check_error=0
        if [ ! -w "/opt/ceyoniq/nscale-pipeliner/workdir/data/backup" ]; then 
            echo "/opt/ceyoniq/nscale-pipeliner/workdir/data/backup not writable with user id " `id -u`
            write_check_error=1
        fi 

        if [ ! -w "/opt/ceyoniq/nscale-pipeliner/workdir/data/error" ]; then 
            echo "/opt/ceyoniq/nscale-pipeliner/workdir/data/error not writable with user id " `id -u`
            write_check_error=1
        fi 

        if [ ! -w "/opt/ceyoniq/nscale-pipeliner/workdir/data/import" ]; then 
            echo "/opt/ceyoniq/nscale-pipeliner/workdir/data/import not writable with user id " `id -u`
            write_check_error=1
        fi 

        if [ ! -w "/opt/ceyoniq/nscale-pipeliner/workdir/data/input" ]; then 
            echo "/opt/ceyoniq/nscale-pipeliner/workdir/data/input not writable with user id " `id -u`
            write_check_error=1
        fi 

        if [ ! -w "/opt/ceyoniq/nscale-pipeliner/workdir/data/output" ]; then 
            echo "/opt/ceyoniq/nscale-pipeliner/workdir/data/output not writable with user id " `id -u`
            write_check_error=1
        fi 

        if [ "0" -eq "$write_check_error" ]; then
               break
        fi
    else 
        echo "Server is not running: ${APPLICATION_LAYER_HOSTNAME} ... retry in 5 seconds."
    fi
    sleep 5
done

