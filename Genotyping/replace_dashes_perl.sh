cut -f3,4 /nexsan2/disk2/ctsa/barnes/ADRN/OMNI/ADRN_Genotyping_499_Samples_GS_FinalReport_04-09-14.txt | perl -p -i -e 's/\-/0/g' > ADRN_Genotyping_499_Samples_GS_FinalReport_dashes_rm2.txt
