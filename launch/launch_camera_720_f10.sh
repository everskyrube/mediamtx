#!/bin/bash

# Check if argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <video_device_number>"
  echo "Example: $0 0  (for /dev/video0)"
  exit 1
fi

DEVICE="/dev/video$1"
STREAM="rtsp://localhost:8554/camera_$1"

ffmpeg \
  -f v4l2 -framerate 10 -video_size 720x640 -i "$DEVICE" \
  -vcodec libx264 -preset ultrafast -tune zerolatency \
  -pix_fmt yuv420p -profile:v baseline -bf 0 -g 30 \
  -f rtsp "$STREAM"
