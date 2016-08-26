#!bin/bash
# C Malley 22 Aug 2016
# NOTICE: You will need absolute paths to all recalibrated bams for each '-I' flag. If you have many samples, use format-filenames.pl to print out all this and simply paste into the java command.

GATK=/users/cmalley/apps/gatk/GenomeAnalysisTK.jar

reference="/dcl01/mathias/data/annovar/humandb/ucsc.hg19.fasta"
knownsnps="/dcl01/mathias/data/annovar/humandb/dbsnp_138.hg19.vcf"

#DIRECTORY="/dcl01/mathias/data/ADRN_EH"
FINALDIR="/dcl01/mathias/data/ADRN_EH/common_analysis/gatk"

java -XX:-UseParallelGC -jar $GATK \
 -R $reference \
 -T HaplotypeCaller \
 -I [absolute path to bam1] \
 -I [absolute path to bam2] \
 --emitRefConfidence GVCF \
 -o $FINALDIR/output.raw.snps.indels.g.vcf \
 -U ALLOW_UNSET_BAM_SORT_ORDER \
 -gt_mode DISCOVERY \
 -mbq 20 -stand_emit_conf 20 -G Standard -A AlleleBalance --disable_auto_index_creation_and_locking_when_reading_rods \
 -nct 6

 exit 0


# Runtime command:
# qsub -cwd -l mem_free=20G,h_vmem=21G,h_fsize=300G -pe local 7
