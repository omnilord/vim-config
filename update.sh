#!/bin/bash

#cp -R bundle bundle_bu_$(date "+%m%d%H%M%Y.%S")

#for d in bundle/*
#do
#  ( cd "${d}" && echo && echo "updating ${d}" && git pull origin master )
#done
#

git submodule update --remote

