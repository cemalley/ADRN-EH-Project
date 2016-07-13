# Pipeline for the Genome Analysis Toolkit (GATK)
Programs by Claire Malley. GATK documentation can be found at https://www.broadinstitute.org/gatk/.

## Order of operations
So far I have tested and run the following steps:

1. Pre-processing with Picard Tools. Mark duplicate reads on every sample. Parallelized for as many threads as there are files. picard.sh is a wrapper for picard1.sh. Monitor which samples have been successfully processed with list-compare.pl. NOTE: Picard tools outputs new bam files of approximately the same size as the original assemblies, so watch out for storage space before running.
2. Base Score Recalibration with GATK. Indel realignment is skipped to minimize compute time. Run gatk.sh (will be uploaded).
