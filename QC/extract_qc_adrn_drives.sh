#!/bin/bash

#Check user parameters
if [ "$#" -eq  "0" ];
then
    echo "Usage: ${0##*/} <parent_dir>"
    exit
fi

#Setup
parent_dir=$1
nr_samples_processed=0
rm ADRN_761_illumina_qc.txt
cd /gpfs/barnes_home/boorgulm/working

#Process per sample (which is in subdirectories)

echo -e "Sample_ID\tFragment_Length_Median\tFragment_Length_SD\tPercent_Callable\tAverage_Coverage\tPercent_Callable_5x\tPercent_Callable_10x\tPercent_Callable_20x\tTotal_SNPs\tTiTV_Ratio\tHET_HOM_Ratio\tPercent_Array_Agreement" > ~/ADRN_761_illumina_qc.txt

for i in ${parent_dir}/*;
do
    sample_id=`echo $i | grep DNA`
    if [ -n "$sample_id" ]
    then

            sample_id=`basename $sample_id`
            echo $sample_id

	#Scrape statistics from the report file
            pdftotext ${parent_dir}/${sample_id}/${sample_id}.SummaryReport.pdf ${sample_id}_report.txt
	    fl_med=`grep -n 'Fragment Length Median' ${sample_id}_report.txt | cut -f3 -d":"`
	    fl_sd=`grep -n 'Fragment Length SD' ${sample_id}_report.txt | cut -f3 -d":"`
            
	    start_pos=`grep -n '% Callable' ${sample_id}_report.txt | cut -f1 -d":"`
            read_pos=`bc <<< $start_pos+11`
            call_pct=`head -$read_pos ${sample_id}_report.txt | tail -1 | sed 's/%//'`
	    
	    read_pos=`bc <<< $start_pos+17`
            avg_cov=`head -$read_pos ${sample_id}_report.txt | tail -1 | sed 's/x//'`

	    read_pos=`bc <<< $start_pos+19`
            call_pct_5x=`head -$read_pos ${sample_id}_report.txt | tail -1 | sed 's/%//'`
	    
	    read_pos=`bc <<< $start_pos+21`
            call_pct_10x=`head -$read_pos ${sample_id}_report.txt | tail -1 | sed 's/%//'`
            
	    read_pos=`bc <<< $start_pos+23`
            call_pct_20x=`head -$read_pos ${sample_id}_report.txt | tail -1 | sed 's/%//'`

	    start_pos=`grep -n 'SNP Assessment' ${sample_id}_report.txt | cut -f1 -d":"`
            read_pos=`bc <<< $start_pos+17`
            nr_snps=`head -$read_pos ${sample_id}_report.txt | tail -1 | sed 's/,//g'`
            
	    read_pos=`bc <<< $start_pos+19`
            titv=`head -$read_pos ${sample_id}_report.txt | tail -1`

	    read_pos=`bc <<< $start_pos+21`
            het_hom=`head -$read_pos ${sample_id}_report.txt | tail -1`
            
	    read_pos=`bc <<< $start_pos+23`
            perc_concordance=`head -$read_pos ${sample_id}_report.txt | tail -1 | sed 's/%//'`
	    echo -e "$sample_id\t$fl_med\t$fl_sd\t$call_pct\t$avg_cov\t$call_pct_5x\t$call_pct_10x\t$call_pct_20x\t$nr_snps\t$titv\t$het_hom\t$perc_concordance" >> ~/ADRN_761_illumina_qc.txt
	    
	    #Clear this sample from the working directory
            rm ${sample_id}*

	nr_samples_processed=$(( $nr_samples_processed + 1 ))
    fi
done

echo "Nr samples processed: $nr_samples_processed"

