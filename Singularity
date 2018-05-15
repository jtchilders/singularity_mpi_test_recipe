Bootstrap: docker
From: centos

%setup
   echo ${SINGULARITY_ROOTFS}
   mkdir ${SINGULARITY_ROOTFS}/myapp
   cp pi.c ${SINGULARITY_ROOTFS}/myapp/


%post
   yum update -y
   yum groupinstall -y "Development Tools"
   yum install -y gcc
   yum install -y gcc-c++
   yum install -y wget
   cd /myapp
   # install MPICH
   wget -q http://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz
   tar xf mpich-3.2.1.tar.gz
   cd mpich-3.2.1
   # disable the addition of the RPATH to compiled executables
   # this allows us to override the MPI libraries to use those
   # found via LD_LIBRARY_PATH
   ./configure --prefix=$PWD/install --disable-wrapper-rpath
   make -j 4 install
   # add to local environment to build pi.c
   export PATH=$PATH:$(pwd)/install/bin
   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)/install/lib
   env | sort
   cd ..
   mpicc -o pi -fPIC pi.c

%runscript
   /myapp/pi

