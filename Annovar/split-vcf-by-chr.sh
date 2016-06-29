#!/bin/bash

# DEPENDENCY: GNU PARALLEL

doit(){
  # This function currently will split genome VCF files by chromosome.


  allchr=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chrX)
  #Run this script a second time for chrY separately, only for those who have it. Uncomment the following and comment out the above.
  #allchr=(chrY)

  for i in ${allchr[@]}
  do
      cd /dcl01/mathias/data/ADRN_EH/${1}/Variations
      genomefile="/dcl01/mathias/data/ADRN_EH/${1}/Variations/${1}.genome.vcf.gz"
      tabix -h $genomefile $i > ${1}.genome.${i}.vcf
      bgzip -c ${1}.genome.${i}.vcf > ${1}.genome.${i}.vcf.gz
      tabix -p vcf ${1}.genome.${i}.vcf.gz
  done
}

export -f doit

#Runtime commands

# For all samples that are usable to the best of our QC knowledge:
#parallel -j 5 doit :::: /home/other/cmalley/adrn/lplist-usable.txt

# For all samples with a Y chromosome:
#parallel -j 5 doit :::: /home/other/cmalley/adrn/lplist-y.txt

# For testing purposes on one sample:
#parallel -j 5 doit :::: /home/other/cmalley/adrn/lplist-justone.txt
