Bootstrap: docker
From: centos

%setup
   echo ${SINGULARITY_ROOTFS}
   mkdir ${SINGULARITY_ROOTFS}/myapp

%files
   pi.c /myapp/
   build.sh /myapp/

%post
   yum update -y
   yum groupinstall -y "Development Tools"
   yum install -y gcc
   yum install -y gcc-c++
   yum install -y wget
   cd /myapp
   ./build.sh
   

%runscript
   /myapp/pi

