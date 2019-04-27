#!/usr/bin/bash

# Folder in which the tests will be performed 
PATHTEST="/afs/cern.ch/work/g/giadarol/afs_phaseout_temptests0"

# The script will stop on the first error 
set -e

# Create the folder
mkdir $PATHTEST

###########################################
# Download and install miniconda (python) #
###########################################

cd $PATHTEST
mkdir downloads
cd downloads

wget https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh
bash Miniconda2-latest-Linux-x86_64.sh -b -p $PATHTEST/miniconda2

######################
# Activate miniconda #
######################

source $PATHTEST/miniconda2/bin/activate
which python

# Set matlplotlib backend to Agg 
# (to avoid errors if display not avaialable)
export MPLBACKEND=Agg

##############################
# Install required libraries #
##############################

pip install numpy
pip install scipy
pip install matplotlib
pip install cython
pip install ipython
pip install h5py

#############################
# Download ABP python toots #
#############################

cd $PATHTEST
git clone https://github.com/PyCOMPLETE/PyECLOUD
git clone https://github.com/PyCOMPLETE/PyPIC
git clone https://github.com/PyCOMPLETE/PyKLU
git clone https://github.com/PyCOMPLETE/PyHEADTAIL
git clone https://github.com/PyCOMPLETE/PyPARIS
git clone https://github.com/PyCOMPLETE/NAFFlib

##########################
# Compile (f2py, cython) #
##########################

cd PyPIC
make

cd ../PyECLOUD
./setup_pyecloud

cd ../PyKLU
./install
cd ..

cd PyHEADTAIL
make
cd ..
mv PyHEADTAIL PyHEADTAIL_inst
mv PyHEADTAIL_inst/PyHEADTAIL .
    
cd NAFFlib/NAFFlib
make py2
cd ../..
mv NAFFlib NAFFlib_inst
mv NAFFlib_inst/NAFFlib .
cd ..

############################################
# Exacute some scripts from the test suite #
############################################

# Execute an example from buildup test suite
cd $PATHTEST/PyECLOUD/testing/tests_buildup
python 000_run_simulation.py --folder LHC_ArcDipReal_450GeV_sey1.70_2.5e11ppb_bl_1.00ns_stress_saver 

# Execute an example from PyEC4PyHT test suite
cd $PATHTEST/PyECLOUD/testing/tests_PyEC4PyHT
python 009_particle_tune_shift_against_HT_multigrid.py

#################################################
# Setup and launch 10 PyECLOUD jobs on HTCondor #
#################################################

# Download example
cd $PATHTEST
git clone https://github.com/giadarol/buildup_study_example

# Setup jobs
cd buildup_study_example
cd config
python config_scan.py

# Launch jobs on htcondor
cd ..
./run_htcondor

####################################################
# Setup and launch 10 instability jobs on HTCondor #
#            (parallel, 8 cores per job)           #
####################################################

# Download example
cd $PATHTEST
git clone https://github.com/giadarol/instability_study_example

# Setup jobs
cd instability_study_example
cd config_PyPARIS
python config_scan.py

# Launch jobs on htcondor
cd ..
./run_PyPARIS_htcondor

### When the jobs are complete, plase launch test_pyecloud_checkres.sh
### to verify that the results are correct

