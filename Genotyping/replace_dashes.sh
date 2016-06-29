cd /nexsan2/disk2/ctsa/barnes/ADRN/OMNI
awk -F "\t" '{gsub(/-/,"0",$3);print}' OFS="\t" ADRN_Genotyping_499_Samples_GS_FinalReport_04-09-14.txt | awk -F "\t" '{gsub(/-/,"0",$4);print}' OFS="\t" > ADRN_Genotyping_499_Samples_GS_FinalReport_dashes_rm_04-09-14.txt
