FROM alpine AS builder

# Download QEMU, see https://github.com/docker/hub-feedback/issues/1261
ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-arm.tar.gz
RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . --strip-components 1

FROM arm64v8/debian:bullseye

LABEL maintainer "Miguel Rasero <miguel@linos.es>"

# Add QEMU
COPY --from=builder qemu-arm-static /usr/bin

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
