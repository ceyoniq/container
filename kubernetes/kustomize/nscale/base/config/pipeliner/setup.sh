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