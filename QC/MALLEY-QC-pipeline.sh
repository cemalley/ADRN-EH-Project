#!/bin/bash

## The data used for QC analysis below are extracted from Illumina's Genotyping VCF files.
## I merged all Genotyping VCFs using bcftools. With this, I made the binary fileset using VCFTOOLS. Then I perform QC with PLINK 1.9, and look for potential genotypic populations across individuals with ADMIXTURE.
## Run the following one line at a time only.

#1. Run merge-parallelized.sh, found in the ANNOVAR directory of this repository, although it does not need to be parallelized.

#2.
vcftools --vcf /dcl01/mathias/data/ADRN_EH/common_analysis/omni/Genotyping_merged.vcf --plink --out Genotyping_merged

#3.
/home/other/cmalley/apps/plink-1.90/./plink --file Genotyping_merged --missing --allow-extra-chr --out missingness

#4. QC filters and LD pruning
/home/other/cmalley/apps/plink-1.90/./plink --geno 0.1 --hwe 0.000001 --maf 0.000001 --file Genotyping_merged --allow-extra-chr --out Genotyping_merged_QC --make-bed

/home/other/cmalley/apps/plink-1.90/./plink --geno 0.1 --hwe 0.000001 --maf 0.000001 --file Genotyping_merged --allow-extra-chr --indep 55 2 2 --make-bed --out Genotyping_LD

/home/other/cmalley/apps/plink-1.90/./plink --bed Genotyping_LD.bed --bim Genotyping_LD.bim --fam Genotyping_LD.fam --extract Genotyping_keep_SNPs.txt --make-bed --out Genotyping_pruned

#5. ADMIXTURE.

#USAGE:  /users/cmalley/apps/admixture_linux-1.3.0/./admixture <plink .bed file> <# populations> <# cores to use>
# For just K = 4:
# /users/cmalley/apps/admixture_linux-1.3.0/./admixture Genotyping_pruned.bed 4 -j4

# For K=1-4 with validation, use second runtime command; see ADMIXTURE manual for interpretation:
for K in 1 2 3 4
  do
    /users/cmalley/apps/admixture_linux-1.3.0/./admixture --cv Genotyping_pruned.bed $K -j4 | tee log${K}.out
  done

exit 0

# RUNTIME COMMANDS

#qsub -cwd -l mem_free=20G,h_vmem=21G,h_fsize=300G plink-QC.sh

# or, for ADMIXTURE with 4 possible K:

#qsub -cwd -l mem_free=20G,h_vmem=21G,h_fsize=300G -pe local 4 plink-QC.sh
