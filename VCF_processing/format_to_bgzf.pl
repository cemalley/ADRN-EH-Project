#!/usr/bin/perl
use strict;
use warnings;

my $pwd = "/nexsan2/disk2/ctsa/mathias/Software/plinkseq/pseq";

for(my $c=1; $c<=22; $c++){
        my $output = "format_to_bgzf_chr".$c.".sh";
        open(OUT, ">$output") or die"Can't open output file\n";
        if($c <10) { 
		print OUT $pwd." /dcs01/mathias/genestar/merged_VCF_EuropeanAmericans/genestar_ea_chr0".$c.".filter.recode.vcf write-vcf --format BGZF --file /dcs01/mathias/genestar/merged_VCF_EuropeanAmericans/genestar_ea_chr0".$c.".filter.recode.vcf.bgzf.gz\n";
		}
	else {
		print OUT $pwd." /dcs01/mathias/genestar/merged_VCF_EuropeanAmericans/genestar_ea_chr".$c.".filter.recode.vcf write-vcf --format BGZF --file /dcs01/mathias/genestar/merged_VCF_EuropeanAmericans/genestar_ea_chr".$c.".filter.recode.vcf.bgzf.gz\n";
		}
	}

exit;

