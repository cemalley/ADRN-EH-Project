#!/bin/bash
#C.Malley July 12 2016

convert2annovar.pl -includeinfo -allsample -withfreq -format vcf4 /dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Allchr_merged.vcf > /dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Allchr_merged.avinput

table_annovar.pl /dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Allchr_merged.avinput /dcl01/mathias/data/annovar/humandb/ -buildver hg19 -out myanno -remove -protocol refGene,snp138,ljb2_sift,ljb2_pp2hdiv -operation g,f,f,f -nastring . -csvout

exit 0
