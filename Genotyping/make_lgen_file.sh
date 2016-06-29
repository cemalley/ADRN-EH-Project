cd /nexsan2/disk2/ctsa/barnes/ADRN/OMNI
awk -F '\t' '{print $2, $2, $1, $3, $4}' OFS="\t"  ADRN_Genotyping_499_Samples_GS_FinalReport_dashes_rm_04-09-14.txt > ADRN_Genotyping.lgen
