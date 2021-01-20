FROM golang:1.15.7-buster

ARG DEBIAN_FRONTEND=noninteractive
ARG IMAGEMAGICK_VERSION=7.0.9-27

RUN apt-get update \
    && apt-get --no-install-recommends -y install -y wget build-essential pkg-config \
    && apt-get --no-install-recommends -y install libjpeg-dev libpng-dev libtiff-dev libgif-dev libraw-dev libwebp-dev \
    && wget https://github.com/ImageMagick/ImageMagick/archive/${IMAGEMAGICK_VERSION}.tar.gz \
    && tar xvzf ${IMAGEMAGICK_VERSION}.tar.gz \
    && cd ImageMagick* \
    && ./configure \
        --without-magick-plus-plus \
        --without-perl \
        --disable-openmp \
        --with-gvc=no \
        --disable-docs \
    && make -j$(nproc) \
    && make install \
    && ldconfig /usr/local/lib \
    && rm -rf /var/lib/apt/lists/* \
    && cd .. \
    && rm -rf ImageMagick*

