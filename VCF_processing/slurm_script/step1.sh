#!/bin/bash

#SBATCH -p defq # Partition
#SBATCH -n 1              # one CPU
#SBATCH -N 1              # on one node
#SBATCH -t 0-1:00         # Running time of 1 hours
#SBATCH --error=job.%J.err # creating error file for each job id's
#SBATCH --share 
#SBATCH --mail-user=aniket.shetty@ucdenver.edu
#SBATCH --mail-type=END
##Read the filenames for each set
cd /gpfs/barnes_share/topmed_freeze2_multi_sample_vcf/snp_file    #######location where the results of each splitted chromosome is stored
Path_tools="/gpfs/barnes_home/shettyan/tools"            #### PATH where the tools are downloaded
seq 0 22 > chr.txt                                   ###creates the file for chromosome list
i=0
while read line; do
((i++))
varname="var$i"
printf -v $varname "$line"
done < chr.txt      

for j in `seq 2 $i`; do

curr_var=var$j
eval curr_var=\$$curr_var
##echo item: $curr_var

if [ "$curr_var" != "" ]; then

id_name=`echo $curr_var | awk 'END {print $1}'`     ### get each of the chromosome number
#f1=`echo $curr_var | awk 'END {print $2}'`
#f2=`echo $curr_var | awk 'END {print $3}'`

name="chr"$id_name                                  ##### chromosome number saved to the variable
filename=$(basename "$1")                            ### extracting filename from the path
extension="${filename##*.}"                          ### extensions of the file
filename="${filename%.*}"                            #### LP6008052-DNA_D01.SNPs.vcf
filename=$(echo $filename | cut -f 1,2 -d '.')       ### extracting filename without extensions
name_file=$filename"."$name                          #### pasting the chromosome number to the filename
bgzip_file=$name_file".recode.vcf"  
tab_file=$bgzip_file".gz"
if [ -d "$name" ]; then                              ### checks if there is a directory of that specific chromosome is present and if yes then enters this loop
cd $name
$Path_tools/vcftools_0.1.13/bin/vcftools --gzvcf $1  --chr $name --recode --recode-INFO-all --out ${name_file}                          #### splits the vcf file into the specific chromosome
$Path_tools/vcftools_0.1.13/bin/vcf-sort $bgzip_file | /gpfs/barnes_home/shettyan/tools/tabix-0.2.6/bgzip  -c > $tab_file               ### sorts the splitted vcf file and bgzips it
$Path_tools/tabix-0.2.6/tabix $tab_file                                                                                                 #### index the splitted vcf file 
cd ../
fi
if [ ! -d "$name" ]; then                             #### ### checks if there is a directory of that specific chromosome is present and if no then enters this loop
mkdir $name
cd $name
$Path_tools/vcftools_0.1.13/bin/vcftools --gzvcf $1  --chr $name --recode --recode-INFO-all --out ${name_file}
$Path_tools/vcftools_0.1.13/bin/vcf-sort $bgzip_file | /gpfs/barnes_home/shettyan/tools/tabix-0.2.6/bgzip  -c > $tab_file
$Path_tools/tabix-0.2.6/tabix $tab_file
cd ../
fi
fi
done
