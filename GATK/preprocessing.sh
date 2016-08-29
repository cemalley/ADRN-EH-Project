#!/bin/bash
# MALLEY JUL 14 2016
# Description: Main program to run GATK analyses post Picard tools work (specifically, after MarkDuplicates)
# Thanks to Mark Miller and Bitsupport admin for the Joint High Performance Computing Exchange (JHPCE) https://jhpce.jhu.edu/
# Dependencies: GNU PARALLEL, SAMTOOLS, GATK, JAVA 1.8


## Program paths ##
GATK=/users/cmalley/apps/gatk/GenomeAnalysisTK.jar
PICARD=/users/cmalley/apps/picard-tools-2.4.1/picard.jar
#SAMTOOLS is in our global cluster path.

## Load in list of sample IDs that passed QC checks. Currently $1 is the sample ID given by GNU Parallel.
sample=($1) ## $sample is ONLY one ID.

## Mark Duplicates (Picard tools) has been completed already so we will use that output bam. ##

marked_duplicates_bam=("/dcl01/mathias/data/ADRN_EH/${sample}/Assembly/${sample}.marked_duplicates.bam")

## Save locations of the reference genome and known SNPs. The reference FASTA must be accompanied by an index file '.fai' and dictionary file '.dict'. These were all downloaded on July 7 2016 from ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/2.8/hg19 and are stored on the JHPCE cluster at /dcl01/mathias/data/annovar

reference="/dcl01/mathias/data/annovar/humandb/ucsc.hg19.fasta"
knownsnps="/dcl01/mathias/data/annovar/humandb/dbsnp_138.hg19.vcf"

## Sort the bam file ##

sortedbam="/dcl01/mathias/data/ADRN_EH/${sample}/Assembly/${sample}.marked_duplicates.sorted.bam"
indexedbam="/dcl01/mathias/data/ADRN_EH/${sample}/Assembly/${sample}.marked_duplicates.sorted.bai"

## Make a temporary directory for SAMTOOLS and Picard to use, unless it already exists ##
DIRECTORY="/dcl01/mathias/data/ADRN_EH/${sample}/Assembly/tmp"
if [ ! -d "$DIRECTORY" ]; then
  mkdir $DIRECTORY
fi

java -d64 -Djava.io.tmpdir=$DIRECTORY -XX:MaxHeapSize=512m -Xms12g -Xmx13g -jar $PICARD SortSam \
      I=$marked_duplicates_bam \
      O=$sortedbam \
      SORT_ORDER=coordinate \
      VALIDATION_STRINGENCY=LENIENT \
      TMP_DIR=$DIRECTORY \
      MAX_RECORDS_IN_RAM=100000

samtools index -b $sortedbam $indexedbam

###

######### GATK PROGRAM RUNS ########

##

#sample_path=("/dcl01/mathias/data/ADRN_EH/${sample}/Assembly/${sample}.marked_duplicates.sorted.bam")

recal_report_path=("/dcl01/mathias/data/ADRN_EH/common_analysis/gatk/recal_reports")

    #1. Base recalibration: make pre-recalibration report

    java -Xmx4g -jar $GATK \
    -T BaseRecalibrator \
    -I /dcl01/mathias/data/ADRN_EH/$sample/Assembly/$sample.marked_duplicates.sorted.bam \
    -R /dcl01/mathias/data/annovar/humandb/ucsc.hg19.fasta \
    -o $recal_report_path/$sample.pre_recalibration_report.grp \
    --num_cpu_threads_per_data_thread 1 
    #--num_threads 4

    #2. Base recalibration: make recalibrated bam

    java -jar $GATK \
    -T PrintReads \
    -R /dcl01/mathias/data/annovar/humandb/ucsc.hg19.fasta \
    -I /dcl01/mathias/data/ADRN_EH/$sample/Assembly/$sample.marked_duplicates.sorted.bam \
    -BQSR $recal_report_path/$sample.pre_recalibration_report.grp \
    -o /dcl01/mathias/data/ADRN_EH/$sample/Assembly/$smaple.recalibrated.bam \
    --num_cpu_threads_per_data_thread 4
    
    #3. Base recalibration: make post-recalibration report

    java -Xmx4g -jar $GATK \
    -T BaseRecalibrator \
    -I /dcl01/mathias/data/ADRN_EH/$sample/Assembly/$sample.marked_duplicates.sorted.bam \
    -R /dcl01/mathias/data/annovar/humandb/ucsc.hg19.fasta \
    -o $recal_report_path/$sample.post_recalibration_report.grp \
    --num_cpu_threads_per_data_thread 1 \
    #--num_threads 4

    #4. Base recalibration: make recalibration plots (validation)

    java -jar $GATK \
    -T AnalyzeCovariates \
    -R /dcl01/mathias/data/annovar/humandb/ucsc.hg19.fasta \
    -before $recal_report_path/$sample.pre_recalibration_report.grp \
    -after $recal_report_path/$sample.post_recalibration_report.grp \
    -plots $sample.recalibration_plots.pdf



#parallel -j 10 main :::: /users/cmalley/adrn/lplist-usable.txt
#parallel -j 5 main :::: /users/cmalley/adrn/lplist-justone.txt
#For quick reference, the above sample ID is LP6005948-DNA_G11

exit 0

## JOB SUBMISSION ##
# qsub -cwd -l mem_free=20G,h_vmem=21G,h_fsize=300G -pe local 5 gatk_streamlined.sh
