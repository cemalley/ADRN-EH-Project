#!/bin/bash
# S. Saini August 4 2016

usable_list=/users/cmalley/adrn/lplist-usable.txt

cat $usable_list  | while read DATAFILE
do

   qsub -cwd -l mem_free=20G,h_vmem=21G,h_fsize=300G SCRIPT.sh $DATAFILE

done


## Replace SCRIPT with:

## 1. picard
## 2. preprocessing
## 3. variantdiscovery

## for each step in order.
