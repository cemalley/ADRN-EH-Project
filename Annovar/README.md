# Format and run data through ANNOVAR
Programs by Claire Malley. Documentation for ANNOVAR can be found at http://annovar.openbioinformatics.org/en/latest/.

# Goals and ethic
Although there are documentation FAQs located on the above site, I'd like to share the successful commands I have run for a set of 48 whole genome sequencing samples on a Sun Grid Engine cluster computer. The goal is to annotate genome VCFs using ANNOVAR. My programmic approach is to dynamically parallelize all this computationally-intensive work. I also aim for short, but easy to read, and well-commented code.

# Dependencies
ANNOVAR program and appropriate sequence databases. http://annovar.openbioinformatics.org/en/latest/user-guide/download/#annovar-main-package
GNU Parallel must be installed on the cluster system which the shell scripts are submitted to. https://www.gnu.org/software/parallel/

# Input
A file containing the WGS sample IDs to be analyzed, one per line. The sample ID ("LP...") is used to locate the appropriate file as well as format the output filenames.

# Final output
Annotated Variant Call Files, one per chromosome, each containing all samples.
A summary of known and novel variants.
