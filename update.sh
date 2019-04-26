#!/bin/bash

cp -R bundle bundle_bu

for d in bundle/*
do
  ( cd "${d}" && echo && echo "updating ${d}" && git pull origin master )
done
