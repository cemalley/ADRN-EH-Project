cd /nexsan2/disk2/ctsa/barnes/ADRN/ADRN_chr01/761MultiVCF
/nexsan2/disk2/ctsa/mathias/Software/vcftools/vcftools --vcf ./ADRN_chr01_742_SNPs_filled_EDC.recode.vcf --minGQ 30 --minDP 7  --recode --recode-INFO-all --out  ./ADRN_chr01_742_SNPs_filled_GQ30_DP7_EDC
/nexsan2/disk2/ctsa/mathias/Software/plinkseq/pseq ./ADRN_chr01_742_SNPs_filled_GQ30_DP7_EDC.recode.vcf  write-vcf --format BGZF --file ./ADRN_chr01_742_SNPs_filled_GQ30_DP7_EDC.recode.vcf.bgzf.gz
