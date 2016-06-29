#!/usr/bin/perl
use strict;
use warnings;

opendir DIR, "./gvcf_scripts";

my @files = readdir(DIR);
my $path = "/datascope/genomics-1/ADRN_chr22/Genome_vcf";
foreach my $f (@files){ 
	system "qsub -o $path -e $path $f";
	}
exit;
