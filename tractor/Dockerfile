FROM centos:6

# Map local assets folder to /opt/pixar/assets
ADD ./assets /opt/pixar/assets

# Pixar license server
RUN rpm -ivh /opt/pixar/assets/PixarLicense-LA-11.0_1457011-linuxRHEL6_gcc44icc121.x86_64.rpm
EXPOSE 9010

# Tractor
RUN rpm -ivh /opt/pixar/assets/Tractor-2.2_1572682-linuxRHEL6_gcc44icc121.x86_64.rpm
EXPOSE 80
EXPOSE 9005

# Set up user
RUN useradd -ms /bin/bash farmer
