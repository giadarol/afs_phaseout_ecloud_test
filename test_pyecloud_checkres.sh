#!/usr/bin/bash

# Folder in which the tests has been performed
PATHTEST="/afs/cern.ch/work/g/giadarol/afs_phaseout_temptests0"

# The script will stop on the first error
set -e

# Activate miniconda
cd $PATHTEST
source $PATHTEST/miniconda2/bin/activate
which python

# Set matplotlib backend to Agg 
# (to avoid errors if display not avaialable)
export MPLBACKEND=Agg

##########################################
# Check that jobs finished correctly     #
# and that outup files are not corrupted #
##########################################

echo "Check buildup jobs:"
cd $PATHTEST/buildup_study_example
python check_output.py

echo "Check instability jobs:"
cd $PATHTEST/instability_study_example
python check_output.py

# Will produce an output like:
#  Check buildup jobs:
#  Successful: 10/10
#  Check instability jobs:
#  Successful: 8/8

