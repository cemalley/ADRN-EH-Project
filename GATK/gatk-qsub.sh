#!/bin/bash
# S. Saini August 4 2016

cat  /users/cmalley/adrn/lplist-usable.txt | while read DATAFILE
do

   qsub -cwd -l mem_free=20G,h_vmem=21G,h_fsize=300G /users/ssaini/recALL/first_step.sh $DATAFILE

done
