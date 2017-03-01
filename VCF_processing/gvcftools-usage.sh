# C Malley March 1 2017
# Purpose: here I use gvcftools' break-blocks to convert a genome VCF into a 'regular' VCF containing only variant sites, without reference blocks. Gvcftools is maintained at https://github.com/sequencing/gvcftools
# Specifically, I need to create a VCF for all ADRN individuals for chrX, using the individual genome VCFs (one per person).
# Dependencies: bcftools, vcftools, htslib, tabix, gvcftools, gzip, bgzip
# Notes: $1 comes from submission script, which embarassingly parallelizes over individual IDs. Merging comes after this is done, with vcf-merge.


chroms=(chrX) # usually I need to extract than one chr in this array

for chr in ${chroms[@]}
do
  cd /dcl01/mathias/data/ADRN_EH/ADRN/transfer

  gzip -dc ${1}.${chr}.genome.vcf.gz | /users/cmalley/apps/gvcftools-0.14/bin/./break_blocks --ref /dcl01/mathias/data/annovar/humandb/ucsc.hg19.fasta > ${1}.${chr}.genome.break.vcf

  bgzip -c ${1}.${chr}.genome.break.vcf > ${1}.${chr}.genome.break.vcf.gz

  tabix -p vcf ${1}.${chr}.genome.break.vcf.gz

  if [ -s ${1}.${chr}.genome.vcf.gz ]
    then

      vcftools --gzvcf ${1}.${chr}.genome.vcf.gz --chr ${chr} --recode --recode-INFO-all --minDP 7 --minGQ 30 --exclude-bed /dcl01/mathias/data/annovar/humandb/hg19_segdup.txt --out ${1}.${chr}.genome.break.filtered

      bgzip -c -f ${1}.${chr}.genome.filtered.recode.vcf > ${1}.${chr}.genome.break.filtered.recode.vcf.gz

      tabix -p vcf ${1}.${chr}.genome.break.filtered.recode.vcf.gz

  fi

done
