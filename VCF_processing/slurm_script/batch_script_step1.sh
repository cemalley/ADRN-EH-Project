#!/bin/bash
export PERL5LIB=~/tools/vcftools_0.1.13/perl            ### PAth to the perl library of vcftools
export PATH=~/tools/tabix/:$PATH                        ###PATH to the tabix library
i=0
while read line; do
((i++))
varname="var$i"
printf -v $varname "$line"
done < /gpfs/barnes_home/shettyan/scripts/split_list_2.txt     ### reading the list of Illumina SNP only vcf files with entire path 

for j in `seq 2 $i`; do

curr_var=var$j
eval curr_var=\$$curr_var
##echo item: $curr_var

if [ "$curr_var" != "" ]; then

id_name=`echo $curr_var | awk 'END {print $1}'`                 #### Assigning the varaible with each file name 
#echo ${id_name}
sbatch /gpfs/barnes_home/shettyan/scripts/step1.sh ${id_name} ### Submitting the job scripts for each file 
sleep 1 # pause 
fi
done
