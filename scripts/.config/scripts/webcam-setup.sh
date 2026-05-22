#!/bin/bash

while ! ip addr show enp11s0f3u1 | rg -q 'inet '; do
  sleep 1
done

PHONE_IP=$(ip neighbor show dev enp11s0f3u1 | awk '{print $1}' | head -1)

ffmpeg -i "http://${PHONE_IP}:1488/video" \
  -vf scale=1280:720,format=yuv420p \
  -f v4l2 /dev/video0
