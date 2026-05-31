#!/bin/sh

ssh phone "cd storage/shared/notes && bash sync.sh"

cd ~/Documents/notes

git pull --rebase

./sync.sh
