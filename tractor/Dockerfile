FROM centos:6
MAINTAINER Fredrik Averpil <fredrik.averpil@gmail.com>

# Pixar license server
COPY assets/PixarLicense-LA-11.0_1457011-linuxRHEL6_gcc44icc121.x86_64.rpm /tmp/PixarLicense.rpm
RUN rpm -ivh /tmp/PixarLicense.rpm
COPY assets/pixar.license /opt/pixar/pixar.license
EXPOSE 9010

# Tractor
COPY assets/Tractor-2.2_1564321-linuxRHEL6_gcc44icc121.x86_64.rpm /tmp/Tractor.rpm
RUN rpm -ivh /tmp/Tractor.rpm
COPY assets/custom_config /opt/pixar/Tractor-2.2/custom_config
EXPOSE 80
EXPOSE 9005

# Set up user
RUN useradd -ms /bin/bash farmer
