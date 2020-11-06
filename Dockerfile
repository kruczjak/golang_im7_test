FROM golang:1.15-buster

RUN apt-get update \
  && apt-get install -y openssh-client git build-essential \
  libpng16-16 libpng-dev libjpeg62-turbo libjpeg62-turbo-dev libwebp6 \
  libwebp-dev libgomp1 libwebpmux3 libwebpdemux2 ghostscript \
  librsvg2-bin librsvg2-dev \
  && \
  # build ImageMagick
  git clone https://github.com/ImageMagick/ImageMagick.git && \
  cd ImageMagick && git checkout 7.0.10-35 && \
  ./configure --without-magick-plus-plus --disable-docs --disable-static --with-rsvg=true \
  && \
  make && make install && \
  ldconfig /usr/local/lib && \
  apt-get remove --autoremove --purge -y build-essential \
  libpng-dev libjpeg62-turbo-dev libwebp-dev libde265-dev libx265-dev && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /ImageMagick
