#!/bin/bash

PORT=9090
name="GLOBAL"
data=$(curl -s "http://localhost:$PORT/proxies")

while true; do
    while true; do
        proxy=$(echo "$data" | jq -r --arg n "$name" '.proxies[$n]')
        type=$(echo "$proxy" | jq -r '.type')
        now=$(echo "$proxy" | jq -r '.now')
        
        if [[ "$type" == "Selector" || "$type" == "Fallback" || "$type" == "URLTest" ]]; then
            name="$now"
        else
            break
        fi
    done

    encoded=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$name'))")
    curl -s "http://localhost:$PORT/proxies/$encoded/delay?url=http://cp.cloudflare.com&timeout=5000" -o /dev/null
    data=$(curl -s "http://localhost:$PORT/proxies")

    proxy=$(echo "$data" | jq --arg n "$name" '.proxies[$n]')
    delay=$(echo "$proxy" | jq -r '.history[-1].delay // empty')
    time=$(echo "$proxy" | jq -r '.history[-1].time // "never"')
    type=$(echo "$proxy" | jq -r '.type')
    udp=$(echo "$proxy" | jq -r '.udp')

    if [[ -z "$delay" ]]; then
        css_class="unknown"
        text="  ms"
    elif [[ "$delay" -lt 150 ]]; then
        css_class="low"
        text="${delay}ms"
    elif [[ "$delay" -lt 225 ]]; then
        css_class="default"
        text="${delay}ms"
    elif [[ "$delay" -lt 300 ]]; then
        css_class="bad"
        text="${delay}ms"
    else
        css_class="ridiculous"
        text="${delay}ms"
    fi

    tooltip="Name: $name
    Type: $type
    Delay: ${delay:-unknown}ms
    UDP: $udp"

    result=$(jq -cn --unbuffered --arg text "$text" --arg tooltip "$tooltip" --arg class "$css_class" \
        '{
            text:$text,
            tooltip:$tooltip,
            class:$class
        }')
    echo "$result" > /tmp/sing-box.json

    sleep 3
done
