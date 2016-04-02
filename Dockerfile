FROM centos:7

# Map folder containing rpms
ADD ./assets/opt/pixar/rpms /opt/pixar/rpms

# Pixar license server
RUN rpm -ivh /opt/pixar/rpms/PixarLicense-LA-11.0_1457011-linuxRHEL6_gcc44icc121.x86_64.rpm
EXPOSE 9010

# Tractor
RUN rpm -ivh /opt/pixar/rpms/Tractor-2.2_1590950-linuxRHEL6_gcc44icc121.x86_64.rpm
EXPOSE 80
EXPOSE 9005

# Additional tools
RUN yum install -y epel-release
RUN yum install -y python-pip
RUN pip install --upgrade pip

# Supervisor
RUN pip install supervisor
RUN mkdir -p /var/log/supervisor

# Set up user
RUN useradd -ms /bin/bash farmer
