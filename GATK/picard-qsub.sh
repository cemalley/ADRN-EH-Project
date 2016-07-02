#!/bin/bash
# C. Malley July 1 2016

cat  /users/cmalley/adrn/lplist-usable.txt | while read DATAFILE
do
   qsub -cwd -l mem_free=20G,h_vmem=21G,h_fsize=300G picard1.sh $DATAFILE
done
