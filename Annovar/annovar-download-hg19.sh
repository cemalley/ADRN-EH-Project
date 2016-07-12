#!/bin/bash
annotate_variation.pl -buildver hg19 -downdb cytoBand /dcl01/mathias/data/annovar/humandb
annotate_variation.pl -buildver hg19 -downdb genomicSuperDups /dcl01/mathias/data/annovar/humandb
annotate_variation.pl -buildver hg19 -downdb -webfrom annovar esp6500siv2_all /dcl01/mathias/data/annovar/humandb
annotate_variation.pl -buildver hg19 -downdb -webfrom annovar 1000g2014oct /dcl01/mathias/data/annovar/humandb
annotate_variation.pl -buildver hg19 -downdb -webfrom annovar snp138 /dcl01/mathias/data/annovar/humandb
annotate_variation.pl -buildver hg19 -downdb -webfrom annovar ljb26_all /dcl01/mathias/data/annovar/humandb
annotate_variation.pl -downdb -buildver hg19 -webfrom annovar ljb2_sift /dcl01/mathias/data/annovar/humandb/
annotate_variation.pl -downdb -buildver hg19 -webfrom annovar ljb2_pp2hdiv /dcl01/mathias/data/annovar/humandb/

#Run with the following command:
#qsub -cwd -l mem_free=20G,h_vmem=21G,h_fsize=300G annovar-download-hg19.sh
