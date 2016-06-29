#!/bin/bash
# Claire Malley
# https://github.com/cemalley/ADRN-EH-Project
# DEPENDENCIES: GNU PARALLEL, BCFTOOLS

doit(){

  # Gather file location information for all samples that are usable to the best of our QC knowledge.
  IFS=$'\n' read -d '' -r -a array < /home/other/cmalley/adrn/lplist-usable.txt

for i in ${array[@]}
do
  j+=("/dcl01/mathias/data/ADRN_EH/${i}/Variations/${i}.genome.${1}.vcf.gz")
done

  k="${j[*]}"
  currentchr=$1
  doanother(){
        # This function performs the merge using BCFTOOLS, a binary refactoring of VCFTOOLS. The VCFTOOLS version of this merge function is not successful as of June 29 2016.
        bcftools merge ${k} -o /dcl01/mathias/data/ADRN_EH/common_analysis/by_chr/${currentchr}_merged.vcf
  }

# The line below will actually run the function.
doanother
}

export -f doit

# For testing the merge on only chromosome 22:
parallel -j 2 doit ::: chr22

# As long as the above is successful, merge on all the remaining chromosomes:
#parallel -j 10 doit ::: chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chrX

#RUNTIME COMMAND

#qsub -cwd -l mem_free=20G,h_vmem=21G,h_fsize=300G merge-parallelized.sh
