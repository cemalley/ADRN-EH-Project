# Pipeline for the Genome Analysis Toolkit (GATK)
Programs by Claire Malley. GATK documentation can be found at https://www.broadinstitute.org/gatk/.

## Order of operations
So far I have tested and run the following steps:

1. Mark duplicate reads with Picard Tools. This step is parallelized for as many threads as there are files. picard.sh is a wrapper for picard1.sh. Monitor which samples have been successfully processed with list-compare.pl. NOTE: Picard tools outputs new bam files of approximately the same size as the original assemblies, so watch out for storage space before running.
2. Sort reads and index the new bam file with Samtools. Run sortbam.sh (will be uploaded).
3. Download resources. Since we have genomes assembled using the hg19 reference, we obtained that reference FASTA. Here is the FTP directory: ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/2.8/hg19/. Download ucsc.hg19.fasta.gz, ucsc.hg19.fasta.fai, ucsc.hg19.fasta.dict.gz ('wget ftp://...file', then 'gunzip file' for each). 
4. Base Score Recalibration with GATK. Note that indel realignment is skipped to minimize compute time. Run gatk.sh (will be uploaded).
