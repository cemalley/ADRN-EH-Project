/datascope/genomics-2/Softwares/Tools/vcftools_0.1.12a/bin/./vcftools --gzvcf /datascope/genomics-1/LP6005994-DNA_A01/Variations/LP6005994-DNA_A01.SNPs.vcf.gz --chr chr22 --recode --recode-INFO-all --out /datascope/genomics-1/ADRN_chr22/SNPs_vcf/LP6005994-DNA_A01.SNPs.chr22
/datascope/genomics-2/Softwares/Tools/tabix-0.2.6/bgzip /datascope/genomics-1/ADRN_chr22/SNPs_vcf/LP6005994-DNA_A01.SNPs.chr22.recode.vcf
/datascope/genomics-2/Softwares/Tools/tabix-0.2.6/tabix /datascope/genomics-1/ADRN_chr22/SNPs_vcf/LP6005994-DNA_A01.SNPs.chr22.recode.vcf.gz
