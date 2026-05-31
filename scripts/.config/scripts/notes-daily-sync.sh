#!/bin/sh

ssh phone "cd storage/shared/notes && git pull --rebase --autostash && bash sync.sh"

cd ~/Documents/notes

git pull --rebase --autostash

./sync.sh
