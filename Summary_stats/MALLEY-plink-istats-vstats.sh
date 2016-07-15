#!/bin/bash

doit(){

  i=$1 ## $i now stores the current sample ID as pulled from each line of lplist-usable.txt

  ## Change the following VCF location and output directory as appropriate
  
  sample_vcf_location=/dcl01/mathias/data/ADRN_EH/${i}/Variations/${i}.genome.vcf
  out_dir=/dcl01/mathias/data/ADRN_EH/common_analysis/

  pseq $sample_vcf_location i-stats >> $outdir/${i}.genome.istats

  pseq $sample_vcf_location v-stats > $outdir/${i}.genome.vstats

}

export -f doit


parallel -j 10 doit :::: /home/other/cmalley/adrn/lplist-usable.txt

## RUNTIME COMMAND ##

# qsub -cwd -l mem_free=20G,h_vmem=21G,h_fsize=300G MALLEY-plink-istats-vstats.sh
