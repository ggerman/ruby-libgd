FROM ruby:4.0.1

RUN apt update && apt -y upgrade
RUN apt install -y \
  build-essential \
  libgd-dev \
  pkg-config \
  libgd3 \
  libgd-tools \
  valgrind

RUN printf "prefix=/usr\n\
exec_prefix=\${prefix}\n\
libdir=\${exec_prefix}/lib/x86_64-linux-gnu\n\
includedir=\${prefix}/include\n\
\n\
Name: gd\n\
Description: GD Graphics Library\n\
Version: 2.3\n\
Libs: -L\${libdir} -lgd\n\
Cflags: -I\${includedir}\n" \
> /usr/lib/x86_64-linux-gnu/pkgconfig/gd.pc

RUN rm -rf /var/lib/apt/lists/*
ENV PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

WORKDIR /app
