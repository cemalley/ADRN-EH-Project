# Pipeline for the Genome Analysis Toolkit (GATK)
Programs by Claire Malley. GATK documentation can be found at https://www.broadinstitute.org/gatk/.

## Order of operations
So far I have tested and run the following steps:

1. Mark duplicate reads with Picard Tools. This step is parallelized for as many threads as there are files. The script picard.sh can be submitted to a cluster computer (such as our SGE) with the script qsub.sh. Monitor which samples have been successfully processed with list-compare.pl. Picard will make new bams with duplicate reads removed.
2. Download the appropriate reference genome. Since we have genomes assembled using the hg19 reference, we obtained that reference FASTA. Here is the FTP directory: ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/2.8/hg19/. Download ucsc.hg19.fasta.gz, ucsc.hg19.fasta.fai, ucsc.hg19.fasta.dict.gz ('wget ftp://...file', then 'gunzip file' for each). 
3. Sort BAM files against the reference genome with Samtools. Then run Base Quality Score Recalibration with GATK. Submit with qsub.sh. Note that indel realignment is skipped to minimize compute time.
4. Run HaplotypeCaller with GATK: variantdiscovery.sh. This is multithreaded but not across cores unless the user submits batches of recalibrated bams through variantdiscovery.sh -- no qsub involved.
