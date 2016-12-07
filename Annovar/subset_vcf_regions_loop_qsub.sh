#!/bin/bash
# C Malley Dec 7 2016

cat /users/cmalley/adrn/chromosomes-1-22.txt | while read DATAFILE
do
  qsub -cwd -l mem_free=20G,h_vmem=21G,h_fsize=300G subset_vcf_regions_loop.sh $DATAFILE
done
