#!/usr/bin/bash

if [ ! -d /opt/ceyoniq/nscale-pipeliner/workdir/data/import/ ]; then
    mkdir -p /opt/ceyoniq/nscale-pipeliner/workdir/data/import/
fi

if [ ! -d /opt/ceyoniq/nscale-pipeliner/workdir/data/error/ ]; then
    mkdir -p /opt/ceyoniq/nscale-pipeliner/workdir/data/error/
fi

if [ ! -d /opt/ceyoniq/nscale-pipeliner/workdir/data/backup/ ]; then
    mkdir -p /opt/ceyoniq/nscale-pipeliner/workdir/data/backup/
fi

if [ ! -d /opt/ceyoniq/nscale-pipeliner/workdir/data/input/ ]; then
    mkdir -p /opt/ceyoniq/nscale-pipeliner/workdir/data/input/
fi

if [ ! -d /opt/ceyoniq/nscale-pipeliner/workdir/data/output/ ]; then
    mkdir -p /opt/ceyoniq/nscale-pipeliner/workdir/data/output/
fi


CONF_DIR=/opt/ceyoniq/nscale-pipeliner/workdir/config/runtime
if [ -w $CONF_DIR/cold.xml ] && [ -f $CONF_DIR/cold.tpl ] && [ -f $CONF_DIR/cold.xslt ]
then
    xsltproc \
      --stringparam napplUsername "${APPLICATION_LAYER_USERNAME}" \
      --stringparam napplPassword "${APPLICATION_LAYER_PASSWORD}" \
      --stringparam nstlUsername "${STORAGE_LAYER_USERNAME}" \
      --stringparam nstlPassword "${STORAGE_LAYER_PASSWORD}" \
      --stringparam dbUsername "${DATABASE_USERNAME}" \
      --stringparam dbPassword "${DATABASE_PASSWORD}" \
      --output $CONF_DIR/cold.xml \
        $CONF_DIR/cold.xslt \
        $CONF_DIR/cold.tpl
fi
