FROM python:3.11

RUN apt-get update && apt-get install -y \
    ruby-full \
    build-essential \
    libgd-dev \
    libgd3 \
    libgd-tools \
    valgrind \
    libzmq3-dev

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

RUN pip install jupyterlab

RUN gem install iruby
RUN iruby register --force
RUN gem install ruby-libgd
RUN gem install libgd-gis

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--ServerApp.token="]
