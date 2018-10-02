#!/usr/bin/env bash
#COBALT -n 2
#COBALT -t 60
#COBALT -q debug-flat-quad
#COBALT -A <project>
#COBALT --jobname atlas_yolo

SINGULARITY_CONTAINER=intelpython.simg
echo container = $SINGULARITY_CONTAINER

# config for Theta (ALCF)
module unload darshan
# app build with GNU not Intel
module swap PrgEnv-intel PrgEnv-gnu
# Use Cray's Application Binary Independent MPI build
module swap cray-mpich cray-mpich-abi

# include CRAY_LD_LIBRARY_PATH in to the system library path
export LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH
# also need this additional library
export LD_LIBRARY_PATH=/opt/cray/wlm_detect/1.3.2-6.0.6.0_3.8__g388ccd5.ari/lib64/:$LD_LIBRARY_PATH
# in order to pass environment variables to a Singularity container create the variable
# with the SINGULARITYENV_ prefix
export SINGULARITYENV_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
# print to log file for debug
echo $SINGULARITYENV_LD_LIBRARY_PATH

PPN=1
NTHDS=128
INTER=1

echo [$SECONDS] run job PPN=$PPN NTHDS=$NTHDS INTER=$INTER COBALT_PARTSIZE=$COBALT_PARTSIZE
aprun -n $(($COBALT_PARTSIZE * ${PPN})) -N ${PPN} -cc depth -d ${NTHDS} -j 2 -e OMP_NUM_THREADS=$NTHDS \
   singularity exec -B /opt/cray:/opt/cray:ro -B /var/opt:/var/opt:ro  $SINGULARITY_CONTAINER  \
   your_exe


echo [$SECONDS] exited $?
