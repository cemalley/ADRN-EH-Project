# Pipeline for the Genome Analysis Toolkit (GATK)
Programs by Claire Malley. GATK documentation can be found at https://www.broadinstitute.org/gatk/.

## Order of operations
So far I have tested and run the following steps:
1. Pre-processing with Picard Tools. Mark duplicate reads on every sample. Parallelized for as many threads as there are files. picard.sh is a wrapper for picard1.sh
