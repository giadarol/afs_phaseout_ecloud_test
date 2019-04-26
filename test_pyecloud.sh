#!/usr/bin/bash

# The script will stop on the first error 
set -e

# This should work when pointed to a EOS path
PATHTEST="/afs/cern.ch/work/g/giadarol/afs_phaseout_tests/pyeclout_test/testfolder"

####echo "Create folder"
####mkdir $PATHTEST
####
####cd $PATHTEST
####
####mkdir downloads
####cd downloads

####wget https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh
####bash Miniconda2-latest-Linux-x86_64.sh -b -p $PATHTEST/miniconda2

source $PATHTEST/miniconda2/bin/activate
which python

# Set matlplotlib backend to Agg (to avoid errors if display not avaialable)
export MPLBACKEND=Agg

####pip install numpy
####pip install scipy
####pip install matplotlib
####pip install cython
####pip install ipython
####pip install h5py
####
####cd $PATHTEST
####git clone https://github.com/PyCOMPLETE/PyECLOUD
####git clone https://github.com/PyCOMPLETE/PyPIC
####git clone https://github.com/PyCOMPLETE/PyKLU
####git clone https://github.com/PyCOMPLETE/PyHEADTAIL
####git clone https://github.com/PyCOMPLETE/PyPARIS
####git clone https://github.com/PyCOMPLETE/NAFFlib
####
####cd PyPIC
####make
####
####cd ../PyECLOUD
####./setup_pyecloud
####
####cd ../PyKLU
####./install
####cd ..
####
####cd PyHEADTAIL
####make
####cd ..
####mv PyHEADTAIL PyHEADTAIL_inst
####mv PyHEADTAIL_inst/PyHEADTAIL .
####    
####cd NAFFlib/NAFFlib
####make py2
####cd ../..
####mv NAFFlib NAFFlib_inst
####mv NAFFlib_inst/NAFFlib .
####cd ..
####
####### Execute an example from PyECLOUD test suite
####cd $PATHTEST/PyECLOUD/testing/tests_buildup
####python 000_run_simulation.py --folder LHC_ArcDipReal_450GeV_sey1.70_2.5e11ppb_bl_1.00ns_stress_saver 

### Execute an example from PyEC4PyHT test suite
cd $PATHTEST/PyECLOUD/testing/tests_PyEC4PyHT
python 009_particle_tune_shift_against_HT_multigrid.py

### Test buildup simulation study
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
