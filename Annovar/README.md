# Format and run data through ANNOVAR
Programs by Claire Malley. Documentation for ANNOVAR can be found at http://annovar.openbioinformatics.org/en/latest/.

## Goals and ethic
Although there are documentation FAQs located on the above site, I'd like to share the successful commands I have run for a set of 48 whole genome sequencing samples on a Sun Grid Engine cluster computer. The goal is to annotate genome VCFs using ANNOVAR. My programmatic approach is to dynamically parallelize all this computationally-intensive work. I have aimed for short, but easy to read, and well-commented code.

## Dependencies
1. ANNOVAR program and appropriate sequence databases. http://annovar.openbioinformatics.org/en/latest/user-guide/download/#annovar-main-package
2. GNU Parallel must be installed on the cluster system to which the shell scripts are submitted. https://www.gnu.org/software/parallel/

The programs can of course be test run on a desktop computer with a bash shell environment.

## Primary input
1. A file containing the WGS sample IDs to be analyzed, one per line. The sample ID ("LP...") is used to locate the appropriate file as well as format the output filenames.
2. Genome VCF files, which Illumina should supply in zipped (".vcf.gz") format.

## Final output
1. Annotated Variant Call Files, one per chromosome, each containing all samples.
2. A summary of known and novel variants per chromosome.

## Order of operations
The last line of each of the following has the exact "qsub" command used to run on the cluster system. Read each file and uncomment/comment out the appropriate GNU parallel command as indicated.

1. annovar-download-hg19.sh
2. split-vcf-by-chr.sh
3. merge-parallelized.sh
4. annovar-run.sh
