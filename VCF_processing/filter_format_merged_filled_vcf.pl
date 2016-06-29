#!/usr/bin/perl
use strict;
use warnings;

my $pwd = "/nexsan2/disk2/ctsa/mathias/Software/vcftools/vcftools";
my $pwd1 = "/nexsan2/disk2/ctsa/mathias/Software/plinkseq/pseq";

for(my $c=1; $c<=22; $c++){
        my $output = "filter_format_merged_filled_vcf_gqx_chr".$c.".sh";
        open(OUT, ">$output") or die"Can't open output file\n";
        if($c <10) {
		print OUT $pwd." --gzvcf /dcs01/mathias/genestar/merged_filled_VCF_EuropeanAmericans/genestar_ea_chr0".$c.".filled.gqx.vcf.gz --minGQ 30 --minDP 7 --exclude-bed /nexsan2/disk2/ctsa/barnes/CAAPA/hg19_segdup.txt --recode --recode-INFO-all --out  /dcs01/mathias/genestar/multiVCF_EA_HOM_gqx30_dp7_segdup_filtered/genestar_ea_chr0".$c."_multiVCF_HOM_gqx30_dp7_segdup.filter";
		print OUT "\n";
		print OUT $pwd1." /dcs01/mathias/genestar/multiVCF_EA_HOM_gqx30_dp7_segdup_filtered/genestar_ea_chr0".$c."_multiVCF_HOM_gqx30_dp7_segdup.filter.recode.vcf write-vcf --format BGZF --file /dcs01/mathias/genestar/multiVCF_EA_HOM_gqx30_dp7_segdup_filtered/genestar_ea_chr0".$c."_multiVCF_HOM_gqx30_dp7_segdup.filter.recode.vcf.bgzf.gz\n";
		}
	else {
		print OUT $pwd." --gzvcf /dcs01/mathias/genestar/merged_filled_VCF_EuropeanAmericans/genestar_ea_chr".$c.".filled.gqx.vcf.gz --minGQ 30 --minDP 7 --exclude-bed /nexsan2/disk2/ctsa/barnes/CAAPA/hg19_segdup.txt --recode --recode-INFO-all --out  /dcs01/mathias/genestar/multiVCF_EA_HOM_gqx30_dp7_segdup_filtered/genestar_ea_chr".$c."_multiVCF_HOM_gqx30_dp7_segdup.filter";
                print OUT "\n";
                print OUT $pwd1." /dcs01/mathias/genestar/multiVCF_EA_HOM_gqx30_dp7_segdup_filtered/genestar_ea_chr".$c."_multiVCF_HOM_gqx30_dp7_segdup.filter.recode.vcf write-vcf --format BGZF --file /dcs01/mathias/genestar/multiVCF_EA_HOM_gqx30_dp7_segdup_filtered/genestar_ea_chr".$c."_multiVCF_HOM_gqx30_dp7_segdup.filter.recode.vcf.bgzf.gz\n";
		}
	}
exit;

