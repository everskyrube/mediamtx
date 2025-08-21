## Real-time video server installation: 

# 1. Download the latest release from GitHub:

git clone https://github.com/bluenviron/mediamtx.git

# 2. Install dependencies:

sudo apt install golang-go

# 3. Locate to the repo directory and build mediamtx:

go build -o mediamtx .

# Run the executable:

./mediamtx 
================================================================================================================================
1. Use a tool like ffmpeg or gstreamer to capture video from the USB camera.
2. Send to MediaMTX:

The FFmpeg command above pushes the stream to MediaMTX using RTSP.

MediaMTX listens on a default RTSP port (8554) and accepts the stream.

3. Clients Connect to MediaMTX:

ffmpeg -f v4l2 -i /dev/video0 -vcodec libx264 -pix_fmt yuv420p -profile:v baseline -bf 0 -g 30 -f rtsp 

================================================================================================================================

## ffmpeg

FFmpeg acts as the bridge between your USB camera and the MediaMTX server.

USB cameras don’t natively output RTSP/WebRTC streams

FFmpeg encodes and wraps the video in a proper streaming format

It allows you to control:

Compression

Frame rate

Latency

Resolution

================================================================================================================================

## Check USB device number:
v4l2-ctl --list-devices

================================================================================================================================

## ffplay

ffplay rtsp://localhost:8554/mystream

================================================================================================================================

## Usage: 

http://localhost:8889/mystream/
================================================================================================================================

## low latency:

ffmpeg \
  -f v4l2 -framerate 30 -video_size 1280x720 -i /dev/video0 \
  -vcodec libx264 -preset ultrafast -tune zerolatency \
  -pix_fmt yuv420p -profile:v baseline -bf 0 -g 30 \
  -f rtsp rtsp://localhost:8554/main_camera

================================================================================================================================

##

ffplay -fflags nobuffer -flags low_delay -vf "drawtext=text='%{pts\:hms}':fontsize=24:fontcolor=white:x=10:y=10" rtsp://localhost:8554/mystream


ffmpeg \
  -f v4l2 -framerate 30 -video_size 1280x720 -i /dev/video2 \
  -vcodec libx264 -preset ultrafast -tune zerolatency \
  -pix_fmt yuv420p -profile:v baseline -bf 0 -g 30 \
  -f rtsp rtsp://localhost:8554/side_camera

================================================================================================================================

## How it works:

How It Works (Simplified)

Capture: Gets audio/video from webcam/mic.

Signal: Exchanges connection info (IP, codec, keys) via a signaling server (not part of WebRTC).

Connect: Establishes a peer-to-peer (or relayed) connection.

Stream: Sends video/audio/data in real time.

## Features: 

📦 No buffering: Streams instantly with almost no delay.

🚫 No B-frames: Requires low-latency encoding (e.g., -bf 0, zerolatency).

💻 Runs in browsers: No plugins needed.

================================================================================================================================

## Camera placement: 
## USB serial bus bandwidth limitation
size: 1280x720
framerate: 10

size: 720x640
size: 640x480


1. Realsense cam (Front_left): Pose visualization, Pointcloud and digging automation
2. USB_cam: (Monitoring digging process)
3. Navigation camera: ardu nightvision cam
4. Back camera / downward camera: for alignment to the benificator
5. Endoscope camera / side_camera