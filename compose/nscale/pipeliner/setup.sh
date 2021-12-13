#!/usr/bin/bash

readonly APPLICATION_LAYER_HOSTNAME=${APPLICATION_LAYER_HOSTNAME:-application-layer}

echo -e $(date '+%d-%b-%Y %H:%M:%S.%3N')" \e[34mWait for application layer...\e[39m"

while : ; do
    status_code=$(curl --max-time 0.1 --head --location --silent --output /dev/null -w "%{http_code}" http://${APPLICATION_LAYER_HOSTNAME}:8080/jmx/status)
    case $status_code in
    200 )
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

        exit $write_check_error
    ;;
    * )
        echo "Server is not running: ${APPLICATION_LAYER_HOSTNAME} ... retry in 5 seconds."
        sleep 5
    ;;
    esac
done

