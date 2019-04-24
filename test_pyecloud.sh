#!/usr/bin/bash

set -e

# This should work when pointed to a EOS path
PATHTEST="/afs/cern.ch/work/g/giadarol/afs_phaseout_tests/pyeclout_test/testfolder"

echo "Create folder"
mkdir $PATHTEST

cd $PATHTEST

mkdir downloads
cd downloads

wget https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh
bash Miniconda2-latest-Linux-x86_64.sh -b -p $PATHTEST/miniconda2
