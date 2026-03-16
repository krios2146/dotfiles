#!/bin/bash

./generate_readme.sh

git add -A

changed_dirs=$(git diff --cached --name-only | awk -F/ '{print $1}' | sort -u)

for dir in $changed_dirs; do
  files=$(git diff --cached --name-only | grep "^$dir/")
  git commit -m "feat($dir): config sync" -- $files
done

git pudge
