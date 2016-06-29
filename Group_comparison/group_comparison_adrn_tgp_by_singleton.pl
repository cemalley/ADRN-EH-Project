#!/usr/bin/perl
use strict;
use warnings;

my $pwd = "/nexsan2/disk2/ctsa/mathias/Software/plinkseq/pseq";

for(my $c=1; $c<=22; $c++){
        my $output = "group_comparison_adrn_tgp_singleton_742_chr".$c.".sh";
        open(OUT, ">$output") or die"Can't open output file\n";
        if($c <10) {
                print OUT "cd /amber2/scratch/schavan/ADRN/GC_TGP_ADRN_maf_filters_742";
                print OUT "\n";
                print OUT $pwd." Analysis_012615_chr0".$c."_gc_adrn_tgp_singleton_742 new-project\n";
                print OUT $pwd." Analysis_012615_chr0".$c."_gc_adrn_tgp_singleton_742 index-vcf --vcf ../ADRN_data_split_by_maf/ADRN_chr0".$c."_742_GQ30_DP7_segdup_singleton.recode.vcf.bgzf.gz --vcf /nexsan2/disk2/1K_hg19_vcf/20120628/20120628_SNPs/ALL.chr0".$c.".phase1.SNPS.segdup.vcf.bgzf.gz\n";
                print OUT $pwd." Analysis_012615_chr0".$c."_gc_adrn_tgp_singleton_742 load-pheno --file /home/jhmi/mboorgu1/group_compare_adrn_742_tgp_pheno.txt\n";
                print OUT $pwd." Analysis_012615_chr0".$c."_gc_adrn_tgp_singleton_742 group-comparison --phenotype Group --mask biallelic > ./gc_adrn_tgp_singleton_742_chr0".$c."_012615.out\n";
                print OUT $pwd." Analysis_012615_chr0".$c."_gc_adrn_tgp_singleton_742 v-view --vmeta >  ./gc_adrn_tgp_singleton_742_chr0".$c."_012615_overlap.out\n";
                }
        else {
              
		print OUT "cd /amber2/scratch/schavan/ADRN/GC_TGP_ADRN_maf_filters_742";
                print OUT "\n";
                print OUT $pwd." Analysis_012615_chr".$c."_gc_adrn_tgp_singleton_742 new-project\n";
                print OUT $pwd." Analysis_012615_chr".$c."_gc_adrn_tgp_singleton_742 index-vcf --vcf ../ADRN_data_split_by_maf/ADRN_chr".$c."_742_GQ30_DP7_segdup_singleton.recode.vcf.bgzf.gz --vcf /nexsan2/disk2/1K_hg19_vcf/20120628/20120628_SNPs/ALL.chr".$c.".phase1.SNPS.segdup.vcf.bgzf.gz\n";
                print OUT $pwd." Analysis_012615_chr".$c."_gc_adrn_tgp_singleton_742 load-pheno --file /home/jhmi/mboorgu1/group_compare_adrn_742_tgp_pheno.txt\n";
                print OUT $pwd." Analysis_012615_chr".$c."_gc_adrn_tgp_singleton_742 group-comparison --phenotype Group --mask biallelic > ./gc_adrn_tgp_singleton_742_chr".$c."_012615.out\n";
                print OUT $pwd." Analysis_012615_chr".$c."_gc_adrn_tgp_singleton_742 v-view --vmeta >  ./gc_adrn_tgp_singleton_742_chr".$c."_012615_overlap.out\n";
                }
        }
exit;

