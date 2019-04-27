#!/usr/bin/bash

# The script will stop on the first error 
set -e

# This should work when pointed to a EOS path
PATHTEST="/afs/cern.ch/work/g/giadarol/afs_phaseout_tests/pyeclout_test/testfolder"


cd $PATHTEST

source $PATHTEST/miniconda2/bin/activate
which python

# Set matlplotlib backend to Agg (to avoid errors if display not avaialable)
export MPLBACKEND=Agg

echo "Check buildup jobs:"
cd $PATHTEST/buildup_study_example
python check_output.py

echo "Check instability jobs:"
cd $PATHTEST/instability_study_example
python check_output.py


