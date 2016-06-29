#!/usr/bin/perl
use strict;
use warnings;

my $file = $ARGV[0];
my @data = ();
my $a = "\$";

open(INFILE, $file) or die"can't open input file\n";
while(my $line = <INFILE>){
	chomp $line;
	$line =~ s/\s//g;
	$line =~ s/cM//g;
	push(@data, $line);
	}

for my $s (@data){
	$s =~ s/\s//g;
	$s =~ s/cM//g;
	my $out = $s.".sh";
	open(OUT, ">$out") or die"Can't open output file\n";
	print OUT "/datascope/genomics\-2/Softwares/Tools/vcftools_0\.1\.12a/bin/\./vcftools --gzvcf /datascope/genomics\-1/".$s."/Variations/".$s.".SNPs.vcf.gz --chr chr22 --recode --recode-INFO-all --out /datascope/genomics\-1/ADRN_chr22/SNPs_vcf/".$s.".SNPs.chr22 ";
	print OUT "&& ";
	print OUT "/datascope/genomics\-2/Softwares/Tools/tabix-0\.2\.6/bgzip /datascope/genomics\-1/ADRN_chr22/SNPs_vcf/".$s.".SNPs.chr22.recode.vcf ";
	print OUT "&& ";
	print OUT "/datascope/genomics\-2/Softwares/Tools/tabix-0\.2\.6/tabix /datascope/genomics\-1/ADRN_chr22/SNPs_vcf/".$s.".SNPs.chr22.recode.vcf.gz\n";
		}
exit;


