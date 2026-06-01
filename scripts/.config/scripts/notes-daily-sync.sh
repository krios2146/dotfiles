#!/bin/sh

MAX_RETRIES=5
RETRY_DELAY=30

for i in $(seq 1 $MAX_RETRIES); do
    ssh -o ConnectTimeout=10 phone "cd storage/shared/notes && git pull --rebase --autostash && bash sync.sh" && break
    echo "Attempt $i failed, retrying in ${RETRY_DELAY}s..."
    sleep $RETRY_DELAY
done

cd ~/Documents/notes
git pull --rebase --autostash
./sync.sh
