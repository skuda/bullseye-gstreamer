FROM debian:bullseye

LABEL maintainer "Miguel Rasero <miguel@linos.es>"

RUN apt-get update \
 && apt-get install -y gstreamer1.0-plugins-bad \
                       gstreamer1.0-libav \
                       gstreamer1.0-plugins-base-apps \
                       gstreamer1.0-plugins-good \
                       gstreamer1.0-plugins-rtp \
                       gstreamer1.0-plugins-ugly \
                       gstreamer1.0-rtsp \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

CMD ["gst-launch-1.0"]
