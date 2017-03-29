# Notes by Claire Malley, March 29, 2017, on how to filter a VCF with bcftools, on site-stats, as well as INFO and FORMAT fields.

# produces a segfault:
bcftools filter -i '%QUAL>20 | INFO/TR>7 | FMT/NR[*]>7' -O v ADRN_EDC_799_platypus_maxvar8_minreads5.norm.vcf.gz > ADRN_EDC_799_platypus_maxvar8_minreads5.norm.QC.GQTRNR.vcf

# works:
bcftools filter -i '%QUAL>20 | INFO/TR>7 | FMT/NR[0]>7' -O v ADRN_EDC_799_platypus_maxvar8_minreads5.norm.vcf.gz > ADRN_EDC_799_platypus_maxvar8_minreads5.norm.QC.GQTRNR.vcf # I think I will just have to assume that NR[0] subscript applies the filter to all samples, and sets any sample with NR less than 7 to a 0/0 genotype. There is very little information online about the 'subscripting,' as in NR[*] versus NR[0] and the documentation is not clear on this point.
