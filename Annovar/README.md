# Format and run data through ANNOVAR
Programs by Claire Malley. Documentation for ANNOVAR can be found at http://annovar.openbioinformatics.org/en/latest/.

## Goals and ethic
Although there are documentation FAQs located on the above site, I'd like to share the successful commands I have run for a set of 48 whole genome sequencing samples on a Sun Grid Engine cluster computer. The goal is to annotate genome VCFs using ANNOVAR. My programmic approach is to dynamically parallelize all this computationally-intensive work. I also aim for short, but easy to read, and well-commented code.

## Dependencies
1. ANNOVAR program and appropriate sequence databases. http://annovar.openbioinformatics.org/en/latest/user-guide/download/#annovar-main-package
2. GNU Parallel must be installed on the cluster system which the shell scripts are submitted to. https://www.gnu.org/software/parallel/

## Primary input
1. A file containing the WGS sample IDs to be analyzed, one per line. The sample ID ("LP...") is used to locate the appropriate file as well as format the output filenames.
2. Genome VCF files, which Illumina should supply in zipped (".vcf.gz") format.

## Final output
1. Annotated Variant Call Files, one per chromosome, each containing all samples.
2. A summary of known and novel variants per chromosome.
