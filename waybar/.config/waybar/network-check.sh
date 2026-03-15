!/bin/bash

while true; do
    flock -n /tmp/network-check.lock curl -s --max-time 5 --retry 2 http://cp.cloudflare.com -o /dev/null
    exit_code=$?

    if [[ $exit_code -gt 1 ]]; then
        class=""
        text=""
    else
        class="disconnected"
        text="disconnected"
    fi

    result=$(jq -cn --unbuffered --arg text "$text" --arg class "$class" '{text:$text, class:$class}')

    echo "$result" > /tmp/network-check.json

    sleep 5
done
