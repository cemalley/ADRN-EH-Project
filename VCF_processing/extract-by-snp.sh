#!/bin/bash

# Extract specific SNPs by rsID from a VCF, using VCFtools.

# Move to the directory you want to create new VCF files in/

cd /dcl01/mathias/data/ADRN_EH/common_analysis/by_chr

# Put SNPs of interest, one per line, into a text file such as "extract.txt." Specify the output filename prefix after --out.

vcftools --vcf chr1_merged.vcf --out OUT_NAME --snps extract.txt --recode

exit 0

# RUNTIME COMMAND

# qsub -cwd -l mem_free=20G,h_vmem=21G,h_fsize=300G extract-by-snp.sh
