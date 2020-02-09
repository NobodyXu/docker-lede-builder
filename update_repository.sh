#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo $0 repository directory
    exit
fi

repository=$1
directory=$2

if [ ! -d $directory ]; then
    exec git clone --depth 1 $repository $directory
else
    cd $directory

    git fetch --depth 1
    git reset --hard origin/master
    exec git gc --aggressive
fi
