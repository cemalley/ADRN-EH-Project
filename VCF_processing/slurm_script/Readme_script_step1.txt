batch_script_step1.sh needs the list file containing ENTIRE PATH of the variants files with the extension "SNPs.vcf.gz"
The list file should be mentioned inside the batch_script_step1.sh with the entire path 
This script calls the step1.sh script, which has the commands to be excuted and the cluster resources it needs to complete the job
So for examples, if your list file has 48 files, the batch_script_step1.sh will call the step1.sh script 48 times and you will see 48 jobs submitted on the cluster
