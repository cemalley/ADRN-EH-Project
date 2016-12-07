# ANNOVAR and carrier counting pipeline
Programs by Claire Malley. Documentation for ANNOVAR can be found at http://annovar.openbioinformatics.org/en/latest/.

## Description
The goal is to annotate whole-genome VCFs using ANNOVAR, then count carriers of variants on a per-site and per-gene basis. The VCF handling is parallelized by threads and cores in a Sun Grid Engine environment. The post-ANNOVAR pipeline is written in R and is engineered for running on a cluster computer in batches of 3-4 chromosomes.

## Dependencies
1. ANNOVAR program and appropriate sequence databases. http://annovar.openbioinformatics.org/en/latest/user-guide/download/#annovar-main-package
2. GNU Parallel must be installed on the cluster system to which the shell scripts are submitted (GNU parallel seems to come bundled with unix and linux systems). https://www.gnu.org/software/parallel/
3. Vcftools and bcftools: https://vcftools.github.io/index.html https://samtools.github.io/bcftools/bcftools.html
4. R installation and several R packages: data.table, stringr, ggplot2, ggthemes, plyr, ggrepel. https://www.r-project.org/

The programs can of course be test run on a desktop computer with a bash shell environment and R installed.

## Primary input
1. File(s) containing the WGS sample IDs to be analyzed, one per line. The sample ID ("LP...") is used to locate the appropriate file, format the output filenames, and later to remove any extraneous samples in VCF files.
2. Genome VCF files, which Illumina supplied in zipped (".vcf.gz") format.

## Final output
1. Annotated Variant Call Files, one per chromosome, each containing all samples.
2. Summaries of carrier status and basic visualization to compare sample groups.
3. Visualization of how variants were annotated, by functional category and sub-categories for exonic variants.

## Order of operations
The last line of each of the following has the exact "qsub" command used to run on the cluster system. For 1-4, read each file and uncomment/comment out the appropriate GNU parallel command as indicated. The R files are 'BATCH' submitted by wrapper qsub shell files, which can be created as described at the end of the programs.

1. annovar-download-hg19.sh
2. split-vcf-by-chr.sh
3. merge-parallelized.sh
4. annovar-run.sh
5. subset_multiannos.R
6. subset_vcf_regions_loop_qsub.sh (runs subset_vcf_regions_loop.sh in parallel by chromosomes)
7. ADNA_EH_PIPELINE_CLUSTER.R
8. concatenate-batches.R
9. visualization.R
