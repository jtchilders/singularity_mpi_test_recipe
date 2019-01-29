#!/bin/bash
#COBALT -n 2
#COBALT -t 15 
#COBALT -q debug-cache-quad 
#COBALT -A <project>

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

env | sort > env.txt

export PATH=/miniconda3/4.5.12/bin:$PATH

aprun -n 2 -N 1 singularity exec -B /opt:/opt:ro /path/to/git/singularity_mpi_test_recipe/miniconda040512.simg /bin/bash -c "export PATH=/miniconda3/4.5.12/bin:\$PATH;python /path/to/git/singularity_mpi_test_recipe/conda/keras_mnist.py"
